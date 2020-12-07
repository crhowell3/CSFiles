/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: December 7, 2020
 * Final Exam: Sieve of Eratosthenes 
 */
#include <stdio.h>
#include <stdbool.h>

/* Constants */
#define SIZE 1000

/* Function protoypes*/
void populateRange();
void sieve();
void countRange();
void printRange();

/* Global variables */
bool num_range[SIZE];
int prime_count = 0;

int main()
{
    populateRange();
    sieve();
    countRange();
    printRange();
    return 0;
}

/*
 * Function: populateRange
 * -----------------------
 * Initializes the array elements to true
 */
void populateRange()
{
    for (int i = 1; i < SIZE; i++)
    {
        num_range[i] = true;
    }
}

/*
 * Function: sieve
 * ---------------
 * Performs the sieve algorithm
 */
void sieve()
{
    for (int i = 2; i <= SIZE; i++)
    {
        if (num_range[i - 1])
        {
            for (int j = i + 1; j <= SIZE; j++)
            {
                if (j % i == 0)
                {
                    num_range[j - 1] = false;
                }
            }
        }
    }
}

/*
 * Function: countRange
 * --------------------
 * After sieving, determines the number of primes in the range
 */
void countRange()
{
    for (int i = 0; i < SIZE; i++)
    {
        if (num_range[i])
        {
            prime_count++;
        }
    }
}

/*
 * Function: printRange
 * --------------------
 * Prints out the primes in the range, then the count
 */
void printRange()
{
    int line_break = 1;
    puts("Prime numbers from 1 - 1000, calculated using the Sieve of Eratosthenes:\n");
    for (int i = 0; i < SIZE; i++)
    {
        if (num_range[i])
        {
            printf("%3d, ", (i + 1));
            if (line_break % 10 == 0)
            {
                printf("\n");
            }
            line_break++;
        }
    }

    printf("\n\nNumber of primes from 1 - 1000: %d\n", prime_count);
}