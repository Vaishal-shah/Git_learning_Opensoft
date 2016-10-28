#include<stdio.h>
#include<stdlib.h>

void normalise(float *u, int *e)
{
	if(*u<10 && *u>=1)
	return;
	if(*u>=10)
	{
		*u=(*u)/10;
		++(*e);
		normalise(u, e);
		return;
	}
	if(*u<1)
	{
		*u= (*u)*10;
		--(*e);
		normalise(u, e);
		return;
	}
}

int main()
{
	int exp;
	float ment;
	printf("enter the mentees");
	scanf("%f", &ment);
	exp=0;
	int *e;
	e=&exp;
	float *u;
	u=&ment;

	normalise(u, e);
	printf("%f, %d\n", ment, exp);
	return 0;
}