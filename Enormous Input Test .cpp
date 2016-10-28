#include<bits/stdc++.h>
using namespace std;
#define gc getchar//_unlocked
#define pc putchar//_unlocked
inline void scanint(int &x)
{    register int c = gc();
    x = 0;
    int neg = 0;
    for(;((c<48 || c>57) && c != '-');c = gc());
    if(c=='-') {neg=1;c=gc();}
    for(;c>47 && c<58;c = gc()) {x = (x<<1) + (x<<3) + c - 48;}
    if(neg) x=-x;
}
inline void printint(int a)
{     register int i=0;
	char S[20];
	while(a>0){S[i++]=a%10+'0';	a=a/10;}
	--i;
	while(i>=0)pc(S[i--]);
	pc('\n');
}

int main()
{ int n,k,t,count=0;
scanf(" %d %d",&n,&k);
while(n--)
{
scanint(t);
if(t%k==0)count++;}
printf("%d\n",count);
return 0;
} 
