/**
 * Autho: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: September 17, 2020
 */
#include <stdio.h>

int main()
{
    float grade;
    char letter;

    printf("Please enter a numerical grade value: ");
    scanf("%f", &grade);

    if (grade >= 89.5)
    {
        letter = 'A';
    }
    else if (grade >= 79.5)
    {
        letter = 'B';
    }
    else if (grade >= 69.5)
    {
        letter = 'C';
    }
    else if (grade >= 59.5)
    {
        letter = 'D';
    }
    else
    {
        letter = 'F';
    }

    printf("\nYour letter grade is: %c\n", letter);

    return 0;
}