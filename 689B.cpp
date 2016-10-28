#include "bits/stdc++.h"

using namespace std;
void _do(const vector<int>& v)
{
    vector<int> ans(v.size(), INT_MAX);
    queue<int> Q;
    Q.push(1);
    ans[1] = 0;
    while(!Q.empty()) {
        const int now = Q.front();
        //cerr << "now = "<< now << '\n';  
        Q.pop();
        if(v[now]!=now && v[now]!=now+1 && v[now]!=now-1 && ans[v[now]] > ans[now] +1) {
            ans[v[now]] = ans[now] + 1;
            //cerr << "shortcut (" << v[now] << ") " << ans[v[now]] << '\n';
            Q.push(v[now]);
        }
        if(now + 1 < v.size() && ans[now+1] > ans[now] + 1) {
            ans[now+1] = ans[now] + 1;
            //cerr << "fwd (" << now+1 << ") " << ans[now+1] << '\n';
            Q.push(now+1);
        }
        if(now-1 > 0 && ans[now-1] > ans[now] + 1) {
            ans[now-1] = ans[now] +1 ;
            //cerr << "bwd (" << now-1 << ") " << ans[now-1] << '\n';
            Q.push(now-1);
        }
    }
    for(int i = 1; i < ans.size(); ++i) {
        cout << ans[i] << ' ';
    }
}
int main()
{
    cin.tie(0);cout.tie(0);std::ios::sync_with_stdio(false);

    int n;
    cin >> n;
    std::vector<int> v(n + 1);
    
    for(int i = 1; i<=n; ++i) {
        cin >> v[i];
        // --v[i];
    }
    _do(v);

    return 0;
}
