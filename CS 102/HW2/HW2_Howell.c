/**
 * Author: Cameron Howell
 * Class: CS 102 Fall 2020
 * Date: September 1, 2020 
 */
#include <stdio.h>

int main()
{
    int age, height, bpm, bagels;
    int magic_num = 0;

    // Prompts and scanf to get user input
    printf("Please enter your age: ");
    scanf("%d", &age);
    printf("Please enter your height in inches: ");
    scanf("%d", &height);
    printf("Please enter your current heart rate: ");
    scanf("%d", &bpm);
    printf("Please enter the number of bagels you have eaten today: ");
    scanf("%d", &bagels);

    // Formula to derive magic number
    magic_num = (age * (height - bagels)) / (bagels % (bpm * 2));

    printf("Your Age: %8s%d years\nYour Height: %5s%d inches\nYour Heartrate: %2s%d beats per minute\nYour Bagel Count: %d bagels for breakfast\n", " ", age, " ", height, " ", bpm, bagels);

    printf("Your Magic #: %4s%d\n", " ", magic_num);
    return 0;
}