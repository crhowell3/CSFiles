/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: November 13, 2020
 */
#include <stdio.h>

#define SIZE 100

int main()
{
    /* Declare array of size 100 */
    int arr[SIZE];
    /* Initialize a sum variable */
    int sum = 0;

    /* Initialize all elements to 0 */
    for (int i = 0; i < SIZE; i++)
    {
        arr[i] = 0;
    }

    /* Print elements in a 10-by-10 arrangemenmt*/
    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            /* Just to get rid of that pesky hanging comma :)*/
            if (10 * i + j == 99)
                printf("%2d", arr[10 * i + j]);
            else
                printf("%2d, ", arr[10 * i + j]);
        }
        printf("\n");
    }

    /* Set elements to their index value */
    for (int k = 0; k < SIZE; k++)
    {
        arr[k] = k;
    }

    /* Print all those new elements */
    printf("\n");
    for (int l = 0; l < 10; l++)
    {
        for (int m = 0; m < 10; m++)
        {
            /* Just to get rid of that pesky hanging comma :)*/
            if (10 * l + m == 99)
                printf("%2d", arr[10 * l + m]);
            else
                printf("%2d, ", arr[10 * l + m]);
        }
        printf("\n");
    }

    /* Print the sum of all the elements */
    for (int m = 0; m < SIZE; m++)
    {
        sum += arr[m];
    }

    printf("\nThe sum of all elements is %d\n", sum);
    return 0;
}