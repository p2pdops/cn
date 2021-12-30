// 8. Implementation of distance vector routing algorithm.

#include <stdio.h>

struct node
{
    unsigned dest[20];
    unsigned from[20];
} rt[10];

int main()
{
    int cost_mat[20][20];
    int nodes, i, j, k, count = 0;
    printf("Enter the number of nodes: ");
    scanf("%d", &nodes);
    printf("Enter the cost matrix:\n");
    for (i = 0; i < nodes; i++)
    {
        for (j = 0; j < nodes; j++)
        {
            scanf("%d", &cost_mat[i][j]);
            cost_mat[i][i] = 0;             // set diagonal to 0
            rt[i].dest[j] = cost_mat[i][j]; // store the cost in the routing table
            rt[i].from[j] = j;              // store the source node in the routing table
        }
    }

    // distance vector algorithm uses Bellman-Ford algorithm
    do
    {
        count = 0;
        for (i = 0; i < nodes; i++)
        {
            for (j = 0; j < nodes; j++)
            {
                for (k = 0; k < nodes; k++)
                {
                    if (cost_mat[i][j] > (cost_mat[i][k] + cost_mat[k][j]))
                    {
                        cost_mat[i][j] = cost_mat[i][k] + cost_mat[k][j];
                        rt[i].dest[j] = cost_mat[i][k] + cost_mat[k][j];
                        rt[i].from[j] = k;
                        count++;
                    }
                }
            }
        }
    } while (count != 0);

    printf("\nThe routing table is:\n");
    for (i = 0; i < nodes; i++)
    {
        printf("\nFor router %d\n", i + 1);
        for (j = 0; j < nodes; j++)
        {
            printf("Node %d via %d distance is %d\n", j + 1, rt[i].from[j] + 1, rt[i].dest[j]);
        }
    }
    printf("\n");

    int source, dest;
    printf("Enter the source node: ");
    scanf("%d", &source);
    printf("Enter the destination node: ");
    scanf("%d", &dest);
    printf("Distance between source node and destination node is %d ",
           rt[source - 1].dest[dest - 1]);

    return 0;
}