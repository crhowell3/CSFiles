/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: September 28, 2020
 */
#include <stdio.h>

int main()
{
    // Initialize input variable and iterator
    int input;
    int iter = 1;

    // Prompt user for input
    printf("Please enter a positive integer: ");
    scanf("%d", &input);

    // Execute print statement, printing incrementally until the value
    // of the iterator is equivalent to the input integer
    while (iter <= input)
    {
        printf("%d\n", iter);
        iter++;
    }

    // Print out the number of times the loop executed
    printf("Loop executed %d times!\n", input);

    return 0;
}