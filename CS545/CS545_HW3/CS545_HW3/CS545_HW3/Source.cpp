/**
 * Author: Cameron Howell
 * Class: CS545 Fall 2020
 * Due Date: November 1, 2020 11:59PM
 * Assignment: Program 3
 * Description: 
 */

#include <cstdlib>
#include <cmath>
#include <iostream>
#include <ctime>
#include <GL/glew.h>
#include <GL/freeglut.h>

void drawScene(void)
{
	glClear(GL_COLOR_BUFFER_BIT);

	glLoadIdentity();

	glPushMatrix();
	glTranslated(sphere_x, sphere_y, 0.0);
	glCallList(sphere);
	glPopMatrix();

	glutSwapBuffers();
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

	glutCreateWindow("Drawing App");

	glutDisplayFunc(drawScene);
	glutReshapeFunc(resize);
	glutKeyboardFunc(keyInput);

	glewExperimental = GL_TRUE;
	glewInit();

	setup();

	glutMainLoop();
}