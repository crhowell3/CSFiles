/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: September 22, 2020
 */
#include <stdio.h>

int main()
{
    // Initialization of floats for input and summation
    float input = 0.0;
    float sum = 0.0;

    // Prompt user for input
    printf("Enter up to 5 numbers, or enter 0 to stop.\n");
    scanf("%f", &input);
    sum += input;
    // Check if the user input 0; if so, terminate program
    // This prompt-check process occurs a max of 5 times
    // Also this is very painful without a while loop >.<
    if (input == 0)
    {
        printf("Your total is:%12.3f\n", sum);
        return 0;
    }
    printf("Your number was:%10.3f\n", input);

    scanf("%f", &input);
    sum += input;
    if (input == 0)
    {
        printf("Your total is:%12.3f\n", sum);
        return 0;
    }
    printf("Your number was:%10.3f\n", input);

    scanf("%f", &input);
    sum += input;
    if (input == 0)
    {
        printf("Your total is:%12.3f\n", sum);
        return 0;
    }
    printf("Your number was:%10.3f\n", input);

    scanf("%f", &input);
    sum += input;
    if (input == 0)
    {
        printf("Your total is:%12.3f\n", sum);
        return 0;
    }
    printf("Your number was:%10.3f\n", input);

    scanf("%f", &input);
    sum += input;
    if (input == 0)
    {
        printf("Your total is:%12.3f\n", sum);
        return 0;
    }
    printf("Your number was:%10.3f\n", input);
    printf("Your total is:%12.3f\n", sum);

    return 0;
}