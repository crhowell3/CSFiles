/**
 * Author: Cameron Howell
 * Class: CS545 Fall 2020
 * Due Date: September 20, 2020 11:59PM
 * Assignment: Program 1
 * Description: OpenGL program that displays a sine/cosine wave with some ability to
 * manipulate that display with various key inputs
 */

#include <cstdlib>
#include <cmath>
#include <iostream>
#include <GL/glew.h>
#include <GL/freeglut.h>

constexpr auto SPACE = 32;

constexpr auto PI = 3.14159265358979324;
static bool swap = true; // Boolean for toggling between cosine and sine

static float variance = 0.0; // Variance for shifting graph left or right
static float vertices = 5.0; // Number of initial sample points for sine wave

void sine(void) {
	float t = 0; // Theta
	int i; // Iterator

	glBegin(GL_LINE_STRIP);
	for (i = 0; i < vertices; ++i) {
		glColor3f(1.0, 0.0, 0.0);
		glVertex3f((100.0 / (2.0 * PI)) * (t + variance), 50.0 * sin(t) + 50, 0.0);
		t += (2.0 * PI) * (1.0 / (vertices - 1.0));
	}
	glEnd();
}

void cosine(void) {
	float t = 0; // Theta
	int i; // Iterator

	glBegin(GL_LINE_STRIP);
	for (i = 0; i < vertices; ++i) {
		glColor3f(1.0, 0.0, 0.0);
		glVertex3f((100.0 / (2.0 * PI)) * (t + variance), 50.0 * cos(t) + 50, 0.0);
		t += (2.0 * PI) * (1.0 / (vertices - 1.0));
	}
	glEnd();
}

void drawScene(void)
{
	glClear(GL_COLOR_BUFFER_BIT);

	glBegin(GL_LINES);
	glColor3f(0.0, 0.0, 0.0);
	glVertex3f(0.0, 50.0, 0.0);
	glVertex3f(100.0, 50.0, 0.0);
	glEnd();

	if (swap) {
		sine();
	}
	else {
		cosine();
	}

	glFlush();
}

void setup(void)
{
	glClearColor(1.0, 1.0, 1.0, 0.0);
}

void resize(int w, int h)
{
	glViewport(0, 0, w, h);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(0.0, 100.0, 0.0, 100.0, -1.0, 1.0);

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
		vertices++;
		glutPostRedisplay();
		break;
	case '-':
		if (vertices > 3) vertices--;
		glutPostRedisplay();
		break;
	case SPACE:
		swap = !swap;
		glutPostRedisplay();
		break;
	default:
		break;
	}
}

void specialKeyInput(int key, int x, int y) {
	switch (key) {
	case GLUT_KEY_LEFT:
		variance -= PI / 8.0;
		glutPostRedisplay();
		break;
	case GLUT_KEY_RIGHT:
		variance += PI / 8.0;
		glutPostRedisplay();
		break;
	}
}

void printInteraction(void)
{
	std::cout << "Interactions:" << std::endl;
	std::cout << "Press +/- to increase/decrease the number of vertices on the circle." << std::endl;
	std::cout << "Press the Spacebar to toggle between a sine wave and a cosine wave." << std::endl;
	std::cout << "Press the left or right arrow key to shift the graph respectively." << std::endl;
}

int main(int argc, char** argv)
{
	printInteraction();
	glutInit(&argc, argv);

	glutInitContextVersion(4, 3);
	glutInitContextProfile(GLUT_COMPATIBILITY_PROFILE);

	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA);

	glutInitWindowSize(500, 500);
	glutInitWindowPosition(100, 100);

	glutCreateWindow("sine.cpp");

	glutDisplayFunc(drawScene);
	glutReshapeFunc(resize);
	glutKeyboardFunc(keyInput);

	glutSpecialFunc(specialKeyInput);

	glewExperimental = GL_TRUE;
	glewInit();

	setup();

	glutMainLoop();
}