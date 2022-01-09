#include <stdio.h>
#include <string.h>

char xor (char a, char b)
{
    if (a == b)
        return '0';
    return '1';
}

    int main()
{
    char input[100], bkpinput[100], temp[100], quot[100];
    char key[30], bkpkey[30], rem[30];
    int msglen, keylen;

    printf("Enter your data: ");
    gets(input);
    printf("Enter divisor: ");
    gets(key);

    msglen = strlen(input);
    keylen = strlen(key);
    strcpy(bkpinput, input);
    strcpy(bkpkey, key);

    printf("Crc encoded data is : %s\n", input);

    for (int i = 0; i < keylen - 1; i++)
        input[msglen + i] = '0';

    for (int i = 0; i < keylen; i++)
        temp[i] = input[i];

    for (int i = 0; i < msglen; i++)
    {
        quot[i] = temp[0];
        for (int j = 0; j < keylen; j++)
            key[j] = (quot[i] == '0') ? '0' : bkpkey[j];
        for (int j = keylen - 1; j > 0; j--)
            rem[j - 1] = xor(temp[j], key[j]);
        rem[keylen - 1] = input[i + keylen];
        strcpy(temp, rem);
    }
    strcpy(rem, temp);

    printf("Quoitent is %s\n", quot);
    printf("Remainder is %s\n", rem);
    printf("Data to send is %s%s\n", bkpinput, rem);

    return 0;
}
