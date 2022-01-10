#include <stdio.h>

int main()
{
    int data[8 + 1], rec[8 + 1];
    printf("Enter 4 bit word: ");

    scanf("%d%d%d%d", &data[3], &data[5], &data[6], &data[7]);

    data[1] = data[3] ^ data[5] ^ data[7];
    data[2] = data[3] ^ data[6] ^ data[7];
    data[4] = data[5] ^ data[6] ^ data[7];

    printf("Data to transmit : ");
    for (int i = 1; i < 7 + 1; i++)
        printf("%d ", data[i]);

    printf("\n Enter data received: ");

    for (int i = 1; i < 8; i++)
        scanf("%d", &rec[i]);

    int c, c1, c2, c3;
    c1 = rec[1] ^ rec[3] ^ rec[5] ^ rec[7];
    c2 = rec[2] ^ rec[3] ^ rec[6] ^ rec[7];
    c3 = rec[4] ^ rec[5] ^ rec[6] ^ rec[7];
    c = 4 * c3 + 2 * c2 + c1;
    if (c)
    {
        printf("Error at position %d \n", c);

        rec[8 - c] = rec[8 - c] ^ 1;
        printf("Corrected data: ");
        for (int i = 1; i < 7 + 1; i++)
            printf("%d ", rec[i]);
    }
    else
    {
        printf("No error in data!\n");
    }
}
