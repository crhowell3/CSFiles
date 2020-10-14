/**
 * Author: Cameron Howell
 * Class: CS545 Fall 2020
 * Due Date: October 11, 2020 11:59PM
 * Assignment: Program 2
 * Description: OpenGL program with the objective of moving a sphere in space
 * inside a cube placed at random in the game world
 */

#include <cstdlib>
#include <cmath>
#include <iostream>
#include <ctime>
#include <GL/glew.h>
#include <GL/freeglut.h>

// Flag to ensure non-concurrent timer functions
static int isAnimate = 0;
// Time incrementer for times function has been executed
static int t = 0;
// Time step in ms between frames
static int animTime = 20;
// Seed the random number generator
static bool const dummy = (srand(time(0)), true);
// Times New Roman font for win text
static long font = (long)GLUT_BITMAP_TIMES_ROMAN_24;
// Initial position for the sphere
static float sphere_x = 250.0, sphere_y = 250.0;
// Randomized intitial position for the cube
static float cube_x = (rand() % 475) + 25.0f, cube_y = (rand() % 475) + 25.0f;
// Sphere object
static unsigned int sphere;

void writeBitmapString(void* font, char* string)
{
	char* c;

	for (c = string; *c != '\0'; c++) glutBitmapCharacter(font, *c);
}

int sphereCollisionCheck(float x, float y) {
	float temp_x1 = cube_x + 25.0;
	float temp_x2 = cube_x - 25.0;
	float temp_y1 = cube_y + 25.0;
	float temp_y2 = cube_y - 25.0;

	return ((x <= temp_x1 && x >= temp_x2) && (y <= temp_y1 && y >= temp_y2));
}

void drawScene(void)
{
	glClear(GL_COLOR_BUFFER_BIT);

	glLoadIdentity();

	glPushMatrix();
		glTranslated(sphere_x, sphere_y, 0.0);
		glCallList(sphere);
	glPopMatrix();

	glPushMatrix();
		glColor3f(0.0, 0.0, 0.0);
		glTranslatef(cube_x, cube_y, 0.0);
		glutWireCube(50);
	glPopMatrix();

	glPushMatrix();
	glColor3f(0.0, 0.0, 0.0);
	glRasterPos3f(200.0, 250.0, 0.0);
	if (sphereCollisionCheck(sphere_x, sphere_y)) {
		writeBitmapString((void*)font, (char*)"YOU WIN");
	}

	glutSwapBuffers();
}

void animateUp(int value) {
	if (isAnimate) {
		t += 1;
		if (t >= 5) {
			isAnimate = 0;
			t = 0;
		}
		sphere_y += 2.0;

		glutPostRedisplay();
		glutTimerFunc(animTime, animateUp, 1);
	}
}

void animateDown(int value) {
	if (isAnimate) {
		t += 1;
		if (t >= 5) {
			isAnimate = 0;
			t = 0;
		}
		sphere_y -= 2.0;

		glutPostRedisplay();
		glutTimerFunc(animTime, animateDown, 1);
	}
}

void animateLeft(int value) {
	if (isAnimate) {
		t += 1;
		if (t >= 5) {
			isAnimate = 0;
			t = 0;
		}
		sphere_x -= 2.0;

		glutPostRedisplay();
		glutTimerFunc(animTime, animateLeft, 1);
	}
}

void animateRight(int value) {
	if (isAnimate) {
		t += 1;
		if (t >= 5) {
			isAnimate = 0;
			t = 0;
		}
		sphere_x += 2.0;
		glutPostRedisplay();
		glutTimerFunc(animTime, animateRight, 1);
	}
}


void setup(void)
{
	sphere = glGenLists(1);
	glNewList(sphere, GL_COMPILE);
	glPushMatrix();
	glColor3f(0.0, 0.0, 0.0);
	glutWireSphere(15, 16, 16);
	glPopMatrix();
	glEndList();

	glClearColor(1.0, 1.0, 1.0, 0.0);
}

void resize(int w, int h)
{
	glViewport(0, 0, w, h);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(0.0, 500.0, 0.0, 500.0, -100.0, 100.0);

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

void keyInput(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 27:
		exit(0);
		break;
	case '+':
		animTime -= 5;
		if (animTime <= 0) {
			animTime = 5;
			std::cout << "Cannot decrease time anymore! Minimum is 5ms per frame." << std::endl;
		}
		else {
			std::cout << "Current time step: " << animTime << "ms." << std::endl;
		}
		break;
	case '-':
		animTime += 5;
		std::cout << "Current time step: " << animTime << "ms." << std::endl;
		break;
	case 'w':
		// Move 10 units up
		if (!isAnimate) {
			isAnimate = 1;
			animateUp(1);
		}
		break;
	case 's':
		// Move 10 units down
		if (!isAnimate) {
			isAnimate = 1;
			animateDown(1);
		}
		break;
	case 'a':
		// Move 10 units left
		if (!isAnimate) {
			isAnimate = 1;
			animateLeft(1);
		}
		break;
	case 'd':
		// Move 10 units right
		if (!isAnimate) {
			isAnimate = 1;
			animateRight(1);
		}
		break;
	default:
		break;
	}
}

void printInteraction(void)
{
	std::cout << "Interactions:" << std::endl;
	std::cout << "Use WASD to move the sphere in the four cardinal directions." << std::endl;
	std::cout << "Use the +/- keys to increment/decrement the time between animation frames in\nintervals of 5ms" << std::endl;
	std::cout << "GOAL: Get the sphere's center point inside the cube." << std::endl;
}

int main(int argc, char** argv)
{
	printInteraction();
	glutInit(&argc, argv);

	glutInitContextVersion(4, 3);
	glutInitContextProfile(GLUT_COMPATIBILITY_PROFILE);

	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);

	glutInitWindowSize(500, 500);
	glutInitWindowPosition(100, 100);

	glutCreateWindow("Sphere Game");

	glutDisplayFunc(drawScene);
	glutReshapeFunc(resize);
	glutKeyboardFunc(keyInput);

	glewExperimental = GL_TRUE;
	glewInit();

	setup();

	glutMainLoop();
}