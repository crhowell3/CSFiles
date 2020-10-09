/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: October 8, 2020
 */
#include <stdio.h>

int main()
{
    // Variable initialization
    int input_amount = 0;
    float num;
    float sum = 0.0;
    int proceed = 1;

    while (proceed)
    {
        // Reset the sum if the user loops back to the start
        sum = 0.0;
        printf("Enter how many numbers you would like to input: ");
        scanf("%d", &input_amount);
        for (int i = 0; i < input_amount; i++)
        {
            printf("Enter any number, or enter 0 to stop: ");
            scanf("%f", &num);
            if (num == 0)
            {
                printf("Stopped!\n");
                break;
            }
            else
            {
                sum += num;
                if (i + 1 != input_amount)
                {
                    printf("Total so far: %f\n", sum);
                }
            }
        }
        printf("Final result: %f\n", sum);
        if (sum >= 90.1)
        {
            printf("%f is ridiculous!\n", sum);
        }
        else if (sum >= 50.51)
        {
            printf("That's slightly respectable!\n");
        }
        else if (sum >= 0)
        {
            printf("A value of %f is low!\n", sum);
        }
        printf("Would you like to restart from the beginning? 0 for NO, 1 for YES: ");
        scanf("%d", &proceed);
    }

    return 0;
}