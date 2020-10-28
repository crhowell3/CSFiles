/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: October 19, 2020
 */
#include <stdio.h>
#include <stdbool.h>

/* Function prototypes */
float add();
float sub();
float mult();
float div();

/*
 * Function: main
 * --------------
 * drives the program, outputs the user prompts and menu
 * calls other functions depending on user input from menu
 */
void main()
{
    while (true)
    {
        int sel = 0;
        float result = 0;
        puts("Welcome to the Calculator App! Choose a function below\n1. Add\n2. Subtract\n3. Multiply\n4. Divide\nPlease enter a selection: ");
        scanf("%d", &sel);

        if (sel == 1)
            result = add();
        else if (sel == 2)
            result = sub();
        else if (sel == 3)
            result = mult();
        else if (sel == 4)
            result = div();

        printf("The result is %.3f\n", result);
    }
}

/*
 * Function: add
 * -------------
 * computes the sum of two numbers
 * 
 * returns: the sum of two user-input numbers
 */
float add()
{
    float a, b;
    puts("Enter the first number: ");
    scanf("%f", &a);
    puts("Enter the second number: ");
    scanf("%f", &b);
    return a + b;
}

/*
 * Function: sub
 * -------------
 * computes the difference of two numbers
 * 
 * returns: the difference of two user-input numbers
 */
float sub()
{
    float a, b;
    puts("Enter the first number: ");
    scanf("%f", &a);
    puts("Enter the second number: ");
    scanf("%f", &b);

    return a - b;
}

/*
 * Function: mult
 * -----------
 * computes the product of three numbers
 * 
 * returns: the product of three user-input numbers
 */
float mult()
{
    float a, b, c;
    puts("Enter the first number: ");
    scanf("%f", &a);
    puts("Enter the second number: ");
    scanf("%f", &b);
    puts("Enter the third number: ");
    scanf("%f", &c);

    return a * b * c;
}

/*
 * Function: div
 * -------------
 * computes the quotient of two numbers
 * 
 * returns: the quotient of two user-input numbers
 */
float div()
{
    float a, b;
    puts("Enter the first number: ");
    scanf("%f", &a);
    puts("Enter the second number: ");
    scanf("%f", &b);

    return a / b;
}