/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: August 24, 2020 
 */
#include <stdio.h>

int main()
{
    int num_one = 156;
    int num_two = 2080;
    int num_three = 12213;

    printf("%5d\n", num_one);
    printf("%6d\n", num_two);
    printf("%10d\n", num_three);
    printf("%7d%7d%7d\n", num_one, num_two, num_three);
    printf("%d %d %d\n", num_one, num_two, num_three);
    return 0;
}