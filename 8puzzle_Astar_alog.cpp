#include "bits/stdc++.h"
#define DEBUG(x) //x
#define BASIC(x) //x
#define SLOWDOWN(x) //x
#define RUN_IDA_STAR
#define RUN_A_STAR
using std::vector;
using std::swap;
using std::set;
using std::multiset;
using std::cout;
using std::cerr;
// #define USE_CHARS
#ifdef USE_CHARS
typedef char num_t;
#else
typedef int num_t;
#endif
using namespace std::chrono;

int H = 2;
class Board{
public:
    static const int N = 3;
    vector<num_t> v;
    num_t blank;
    Board(){v.resize(N*N, 0);}
    Board(const vector<num_t>& x):v(x){
        const auto tm = std::find(v.cbegin(), v.cend(), 0);
        DEBUG(if(tm == v.cend())
            throw std::runtime_error("No blank found");)
        blank = tm-v.cbegin();
    }
    static Board getNew() {
        static vector<num_t> a({0,1,2,3,4,5,6,7,8});
        do {
            std::random_shuffle(a.begin(), a.end());
        } while(!Board(a).isSolvable());
        DEBUG(for(auto i: a) cerr << i << ' '; cerr << '\n';)
        Board b(a);
        BASIC(cerr << "Generated:\n";b.print_board());
        return b;
    }
    // Board(const Board&) DELETE;
    // Board(Board&&) DELETE;
    int getInvCount() {
        int inv_count = 0;
        for (int i = 0; i < N*N - 1; i++)
            for (int j = i+1; j < N*N; j++)
                 if (v[j] && v[i] && v[i] > v[j])
                      inv_count++;
        return inv_count;
    }
    inline bool isSolvable() {
        return getInvCount()% 2 == 0;
    }
    enum where {right = 0, down, left, up};
    bool operator < (const Board& x) const {
        if(blank != x.get_blank())
            return blank <= x.get_blank();
        int i = 0;
        for(const auto& it: v) {
            if(it != x.get_piece(i))
                return it < x.get_piece(i);
            ++i;
        }
    }
    bool operator == (const Board &x) const {
        if(blank != x.blank)
            return false;
        for(int i = 0; i < N*N; ++i) {
            if(v[i] != x.v[i])
                return false;
        }
        return true;
    }
    int h() const {
        switch(H) {
            case 0: //h(n) = 0: 
                return 0;
            case 1: //h(n) = number of misplaced tiles
                {
                    int ret = 0;
                    for(int i = 0; i < N*N; ++i) {
                        if(i == blank)
                            continue;
                        if(v[i] != i+1)
                            ++ret;
                    }
                    return ret;
                }
            case 2: //h(n)=the sum of the distances of the tiles from their goal position
                {
                    int ret = 0;
                    for(int i = 0; i < N*N; ++i) {
                        if(v[i] == 0 || v[i] == i + 1)
                            continue;
                        const int target[] = {(v[i])/N, (v[i]-1)%N};
                        const int now[] = {i/N, i%N};
                        ret += abs(target[0] - now[0]);
                        ret += abs(target[1] - now[1]);                        
                    }
                    return ret;
                }
        }
    } 

    num_t get_blank() const {return blank;}
    num_t get_piece(const int x) const {return v[x];}
    void update_blank() {for(const auto& i: v) if(i == 0) {this->blank = i; return;}}
    void move_blank(const int n);
    bool can_move(const int n);
    bool success() const{
        int x = 1;
        if(this->blank != N*N -1)
             return false;
        for(int i = 0; i < N*N-1; ++i) {
            if(v[i] != i + 1)
                return false;
        }
        return true;
    }
    void print_board() const {
        // if(rand() % 15)
        // system("clear");
        int x = 0;
        static int cnt = 0;
        cout << "\n--("<< cnt++ <<")--";
        for(const auto& i: v) {
            if(x++ % N == 0)
                cout << '\n';
            cout << i << ' ';
        }
        cout << "\n------\n";
    }
    unsigned solve();
    bool valid() const {
        std::unordered_set<int> x;
        for(int i = 1; i < N*N; ++i)
            x.insert(i);
        for(const auto& i: v) {
            x.erase(i);
        }
        return x.size() == 0;
    }
    unsigned solve_ida();
    std::pair<unsigned,bool> solve_ida_h(Board root, const unsigned g, const unsigned bound, unsigned&, multiset<Board>&);
};
const unsigned inf = 1 << 30;
unsigned Board::solve_ida() {
    unsigned bound = this->h();
    unsigned expanded = 0;
    multiset<Board> mem;
    DEBUG(
        unsigned rmbr = 0;
        )
    while(1) {
        SLOWDOWN(std::this_thread::sleep_for(std::chrono::milliseconds(5));)
        DEBUG(
            cerr << "bound: " << bound << ' ' << "expand: " << bound - rmbr << '\t';// << '\n';
            )
        mem.clear();
        const auto _t = solve_ida_h(*this, 0, bound, std::ref(expanded), std::ref(mem));
        if(_t.second){
            BASIC(cout << "Found solution\n");
            return expanded;
        }
        DEBUG(
        assert(_t.first >= bound);
        )
        DEBUG(
            rmbr = bound;
            )
        bound = _t.first;
        // DEBUG(
            // if(bound == inf) cerr << bound << '\n'; throw 1;
            // )
    }
}
std::pair<unsigned, bool> Board::solve_ida_h(Board root, const unsigned g, const unsigned bound, unsigned& expanded, multiset<Board>& mem) {
    const unsigned f = root.h() + g;
    mem.insert(root);
    if(f > bound)
        return {f, 0};
    ++expanded;
    if(root.success())
        return {f, 1};
    unsigned mini = (1 << 30);
    for(int i = 0 ; i < 4; ++i) {
        if(root.can_move(i)) {
            Board tmp(root);
            tmp.move_blank(i);
            if(mem.find(tmp) != mem.cend()) continue;
            const auto _t = solve_ida_h(tmp, g+1, bound, expanded, mem);
            if(_t.second)
                return {f, 1};
            mini = std::min(mini, _t.first);
        }
    }
    auto it = mem.find(root);
    auto it2 = it;++it2;
    mem.erase(it, it2);
    DEBUG(
        if(mini == 1 << 30)
        cerr << mini << '\n';
    )
    return {mini, 0};
}
unsigned Board::solve() {
    unsigned count = 0;
    std::multimap<size_t, Board> q;
    std::set<Board> vis;
    q.insert({this->h(), *this});
    while(!q.empty()) {
        // cerr << "working\n";
        Board x(std::move(q.cbegin()->second));
        q.erase(q.cbegin());
        if(vis.find(x) != vis.end()) {            
            continue;
        }
        ++count;
        DEBUG(x.print_board();)
        // getchar();
        // system("clear");
        vis.insert(x);
        if(x.success()) {
            BASIC(cout << "Found solution\n";
            x.print_board();)
            return count;
        }
        // DEBUG(cerr << "can move: ";)
        for(int i = 0; i < 4; ++i) {
            if(x.can_move(i)) {
                Board tmp(x);
                tmp.move_blank(i);
                // DEBUG(if(!))
                if(vis.find(tmp) == vis.cend()){
                    q.insert({tmp.h(), tmp});
                    // DEBUG(cerr << "'can' move: " << i << ' ';);
                }
                // DEBUG( else {cerr << "cant moved: " << i << ' ';/*tmp.print_board();*/})
            }
            // DEBUG( else cerr << "cant movei: " << i << ' ';)
        }

    }
    BASIC(cout << "No solution found\n";)
    return -1;
}
void Board::move_blank(const int n) {
    DEBUG(if(this->blank < 0 || this->blank >= N*N) {
        throw std::runtime_error("Invalid blank location\n");
    })
    DEBUG(Board _tmmp =*this;try{)
    switch(n) {
    case where::right:
        DEBUG(
            if((this->blank+1)%N == 0 || this->blank+1 >= N*N)
                throw std::runtime_error("can't move to right\n");
            );
        std::swap(v.at(this->blank+1), v.at(this->blank));
        ++this->blank;
        break;
    case where::down:
        DEBUG(
            if(this->blank > N*N-N-1 || this->blank+N >= N*N)
                throw std::runtime_error("can't move down\n");
            );
        std::swap(v.at(this->blank), v.at(this->blank+N));
        this->blank+=N;
        break;
    case where::left:
        DEBUG(
            if((this->blank)%N == 0 || this->blank+1 > N*N) {
                throw std::runtime_error("can't move to left\n");
            });
        std::swap(v.at(this->blank-1), v.at(this->blank));
        --this->blank;
        break;
    case where::up:
        DEBUG(
            if(this->blank < N || this->blank-N < 0) {
                throw std::runtime_error("can't move up\n");
            });
        std::swap(v.at(this->blank), v.at(this->blank-N));
        this->blank-=N;
        break;
        default:
            DEBUG(throw std::runtime_error("invalid switch in Board::move_blank"));
    }
    DEBUG(} catch(...) {
        cerr << "invalid move: " << n << '\n';
        cerr << "Blank was " << _tmmp.blank << '\n';
        cerr << "Can move: " << _tmmp.can_move(n) << '\n';
        _tmmp.print_board();
        this->print_board();
        throw 1;
    })
}
bool Board::can_move(const int n) {
    switch(n) {
        case where::right: return (this->blank+1)%N != 0;
        case where::down: return (this->blank) < N*(N-1);
        case where::left: return this->blank%N != 0;
        case where::up: return this->blank >= N;
        default:
            DEBUG(throw std::runtime_error("invalid switch in Board::can_move"));
    }
}
template<typename T>
void write_to_file(const std::string& s, const T& x) {
    std::ofstream f(s, std::ios::app);
    f << x;
    f.close();
}
int main() {
    // std::vector<int> v( {4, 1, 3,
    //                      0, 8, 5,
    //                      2, 7, 6});
    // Board x(v);
    srand(time(0));
    const unsigned X = 100;
    // std::vector<unsigned> v[3];
    vector<Board> _wh(X);
    for(auto& i: _wh)
        i = Board::getNew();
    const std::vector<Board> wh(std::move(_wh));
#ifdef RUN_IDA_STAR
    std::ofstream f_ida;//("ida" + rand()%10000, std::ios::app);
    std::string s("ida" + std::to_string(rand()%10000));
    cout << "Running IDA* " << s << ' ' << X << "\n";
    f_ida.open(s, std::ios::app);
    f_ida << "IDA*\n";
    f_ida.close();
    for(int i = 0; i < 3; ++i) {
        f_ida.open(s, std::ios::app);
        ::H = i;
        cout << "H = " << i << '\n';
        f_ida << "H = " << i << '\n';
        f_ida.close();
        auto start = std::chrono::high_resolution_clock::now();
        for(const auto& i: wh) {
            f_ida.open(s, std::ios::app);
            SLOWDOWN(std::this_thread::sleep_for(std::chrono::milliseconds(5));)
            Board tmp = i;
            // Board tmp2 = i;
            // tmp.print_board();
            auto ans = tmp.solve_ida();
            cout << ans << '\n';
            f_ida << ans << '\n';
            f_ida.close();
            // else cout << "skipped\n";
        }
        auto end = std::chrono::high_resolution_clock::now();
        auto tm = std::chrono::duration_cast<duration<double>>(end-start); 
        cout << "\nTime " << (tm).count() << '\n';
        f_ida.open(s, std::ios::app);
        f_ida << "\nTime " << (tm).count() << '\n';
        cout << '\n';
        f_ida << '\n';
        f_ida.close();
    }
#endif
#ifdef RUN_A_STAR
    const std::string s2("astar" + std::to_string(rand()%1000));
    cout << "\nA* " << s2 << "\n";
    write_to_file(s2, "\nA*\n");
    for(int i = 0; i < 3; ++i) {
        ::H = i;
        cout << "H = " << i << '\n';
        auto start = std::chrono::high_resolution_clock::now();
        write_to_file(s2, "H = " +std::to_string(i) +'\n');
        for(const auto& i: wh) {
            SLOWDOWN(std::this_thread::sleep_for(std::chrono::milliseconds(5));)
            Board tmp = i;
            // Board tmp2 = i;
            // tmp.print_board();
            const auto ans = tmp.solve();
            cout << ans << '\n';
            write_to_file(s2, std::to_string(ans) +'\n');
            // else cout << "skipped\n";
        }
        auto end = std::chrono::high_resolution_clock::now();
        auto tm = std::chrono::duration_cast<duration<double>>(end-start); 
        write_to_file(s2, "\nTime " + std::to_string(tm.count()) + '\n');
        cout << "\nTime " + std::to_string(tm.count()) << '\n';
        write_to_file(s2, '\n');
        cout << '\n';
    }
#endif
}
// [0]: 111316, 570
// [1]: 861, 445
// [2]: 203, 490
// std::vector<int> v( {4, 1, 3,
//                      0, 8, 5,
//                      2, 7, 6});
