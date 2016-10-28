#include <bits/stdc++.h>
using namespace std;

int main()
{
	cin.tie(0);cout.tie(0);std::ios::sync_with_stdio(false);

	int i,j,n;
	cin >> n;
	vector<bool> v(n, false);
	vector<int> v2;
	for(int i=0;i<n;++i) {
		cin >> j;
		v[i] = j;
		if(j == 1) {
			v2.push_back(i);
		}
	}
	int v2_sz = v2.size();
	if(v2_sz == 0) {
		cout << 0 << '\n';
		return 0;
	}
	if(v2_sz == 1) {
		cout << 1 << '\n';
		return 0;
	}
	long long ans = 1LL;
	for(i = 0; i<v2_sz-1; ++i) {
		ans *= (v2[i+1] - v2[i]);
	}
	cout << ans;
	return 0;
}
