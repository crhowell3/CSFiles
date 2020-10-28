/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: October 30, 2020
 */
#include <stdio.h>
#include <math.h>

/* Function prototypes */
float add(float, float);
float sub(float, float);
float mult(float, float, float);
float div(float, float);
float power(float, float);
float trig(float, int);

/*
 * Function: main
 * --------------
 * drives the program, outputs the user prompts and menu
 * calls other functions depending on user input from menu
 */
void main()
{
    while (1)
    {
        int selection = 0;
        float result = 0.0;
        float a, b, c;
        int func;

        puts("Welcome to the Calculator App! Choose a function below\n1. Add\n2. Subtract\n3. Multiply\n4. Divide\n5. Exponentiate\n6. Trigonometry\nPlease enter a selection: ");
        scanf("%d", &selection);

        if (selection == 1)
        {
            puts("Enter the first number: ");
            scanf("%f", &a);
            puts("Enter the second number: ");
            scanf("%f", &b);
            result = add(a, b);
        }
        else if (selection == 2)
        {
            puts("Enter the first number: ");
            scanf("%f", &a);
            puts("Enter the second number: ");
            scanf("%f", &b);
            result = sub(a, b);
        }
        else if (selection == 3)
        {
            puts("Enter the first number: ");
            scanf("%f", &a);
            puts("Enter the second number: ");
            scanf("%f", &b);
            puts("Enter the third number: ");
            scanf("%f", &c);
            result = mult(a, b, c);
        }
        else if (selection == 4)
        {
            puts("Enter the first number: ");
            scanf("%f", &a);
            puts("Enter the second number: ");
            scanf("%f", &b);
            result = div(a, b);
        }
        else if (selection == 5)
        {
            puts("Enter the base: ");
            scanf("%f", &a);
            puts("Enter the exponent: ");
            scanf("%f", &b);
            result = power(a, b);
        }
        else if (selection == 6)
        {
            puts("Enter theta: ");
            scanf("%f", &a);
            puts("Choose a function:\n1. sin(x)\n2. cos(x)\n3. tan(x)");
            scanf("%d", &func);
            result = trig(a, func);
        }

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
float add(float a, float b)
{
    return a + b;
}

/*
 * Function: sub
 * -------------
 * computes the difference of two numbers
 * 
 * returns: the difference of two user-input numbers
 */
float sub(float minuend, float subtrahend)
{
    return minuend - subtrahend;
}

/*
 * Function: mult
 * -----------
 * computes the product of three numbers
 * 
 * returns: the product of three user-input numbers
 */
float mult(float a, float b, float c)
{
    return a * b * c;
}

/*
 * Function: div
 * -------------
 * computes the quotient of two numbers
 * 
 * returns: the quotient of two user-input numbers
 */
float div(float divisor, float dividend)
{
    return dividend / divisor;
}

/*
 * Function: power
 * ---------------
 * computes the value of raising a base to an exponent
 * 
 * returns: the value of the exponentiation
 */
float power(float base, float exponent)
{
    return pow(base, exponent);
}

/*
 * Function: trig
 * --------------
 * allows user to select a trig function, then computes the result
 * of provided theta and trig function
 * 
 * returns: the value of the trigonometric function
 */
float trig(float theta, int func)
{
    float result;
    if (func == 1)
    {
        result = sin(theta);
    }
    else if (func == 2)
    {
        result = cos(theta);
    }
    else if (func == 3)
    {
        result = tan(theta);
    }
    return result;
}