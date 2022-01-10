#include <stdio.h>
#include <stdlib.h>

int main()
{
	int i, n, r, a;
	printf("Enter no. of packets to transmit:");
	scanf("%d", &n);

	for (int i = 0; i < n; i++)
	{
		printf("\nThe packet %d is sent ", i + 1);
		r = rand() % 2;
		if (r == 1)
		{
			if (rand() % 2 == 1)
			{
				printf("\n ACK number : %d", i + 1);
			}
			else
			{
				printf("\n No ACK for : %d", i + 1);
				i--;
			}
		}
		else
		{
			printf("\n Timeout happened before ACK");
			i--;
		}
	}
}