#include <iostream>
#include <stdio.h>
#include <queue>
#include <map>
#include <algorithm>
using namespace std;
 
 
int main() {
	//ker_x[4]={1,0,-1,0};
	//ker_y[4]={0,-1,0,1};
    queue <pair<int,int> > q;
    map <pair<int,int>,int> visit;
    map <pair<int, int>, pair<int, int> > parent;
    visit.clear();
    pair<int,int> c,cn;
    int i,j, m, n;
    printf("enter the size of the grid in the order of row column");
    scanf("%d %d", &m, &n);
    printf("enter the initial point\n");
    scanf("%d %d", &i, &j);
    c = make_pair(i,j);
    q.push(c);
    visit[c]=1;
    parent[c]= c;
    while(!q.empty())
    {
    	c=q.front();
        printf("pop element= %d %d, parent element= %d %d\n",c.first, c.second, parent[c].first, parent[c].second);
    	q.pop();
    	if(c.first+1 < m ){
    		cn=make_pair(c.first+1,c.second);
    		if(visit[cn]==0){
             q.push(cn);
             parent [cn]= c;
             visit[cn]=1;
            }
    	}
    	if(c.second+1 < n){
    		cn=make_pair(c.first,c.second+1);
    		if(visit[cn]==0){ 
                q.push(cn);
                 parent [cn]= c;
                visit[cn]=1;
            }
    	}
    	if(c.first-1 >= 0 ){
    		cn=make_pair(c.first-1,c.second);
    		if(visit[cn]==0) {
                q.push(cn);
                 parent [cn]= c;
                visit[cn]=1;
            }
    	}
    	if(c.second -1 >= 0)
    	{
    		cn=make_pair(c.first,c.second-1);
    		if(visit[cn]==0){
                q.push(cn);
                 parent [cn]= c;
                visit[cn]=1;
            }
    	}
    }
	return 0;
}