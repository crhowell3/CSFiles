/**
 * Author: Cameron Howell
 * Class: CS545 Fall 2020
 * Due Date: November 30, 2020 11:59PM
 * Assignment: Program 4
 * Description: Program that simulates lighting on a Utah Teapot
 * OpenGL model. Allows the user to interact with the light and 
 * its individual lighting components
 */

#include <cstdlib>
#include <cmath>
#include <iostream>
#include <ctime>
#include <vector>
#include <string>
#include <GL/glew.h>
#include <GL/freeglut.h>

// Diffuse RGB values
static float dR = 0.0;
static float dG = 0.0;
static float dB = 0.0;
// Specular RGB values
static float sR = 0.0;
static float sG = 0.0;
static float sB = 0.0;
// Position of the first light
static float xPos1 = 0.0;
static float yPos1 = 2.0;
static float zPos1 = 2.0;
// Position of the second light
static float xPos2 = 0.0;
static float yPos2 = 2.0;
static float zPos2 = 2.0;
// Shininess value of the teapot
static float shine = 50.0;

// Boolean to toggle the diffuse component
static bool diffuseOn = false;
// Boolean to toggle the specular component
static bool specularOn = false;
// Boolean to enable the second light source
static bool enableLight2 = false;

/// <summary>
/// Initializes the OpenGL components for the program
/// </summary>
/// <param name=""></param>
void setup(void)
{
	glClearColor(1.0, 1.0, 1.0, 0.0);
	glEnable(GL_DEPTH_TEST);

	// Enable lighting
	glEnable(GL_LIGHTING);

	// Initialize values for the light's components
	float ambient[] = { 0.0, 0.0, 0.0, 1.0 };
	float diffuse1[] = { 0.0, 0.0, 0.0, 1.0 };
	float specular1[] = { 0.0, 0.0, 0.0, 1.0 };
	float diffuse2[] = { 1.0, 1.0, 1.0, 1.0 };
	float specular2[] = { 1.0, 1.0, 1.0, 1.0 };
	float globalAmb[] = { 0.2, 0.2, 0.2, 1.0 };

	// Set the properties of the first light
	glLightfv(GL_LIGHT0, GL_AMBIENT, ambient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse1);
	glLightfv(GL_LIGHT0, GL_SPECULAR, specular1);

	// Set the properties of the second light
	glLightfv(GL_LIGHT1, GL_AMBIENT, ambient);
	glLightfv(GL_LIGHT1, GL_DIFFUSE, diffuse2);
	glLightfv(GL_LIGHT1, GL_SPECULAR, specular2);

	// Enable the first light by default
	glEnable(GL_LIGHT0);
	// Initialize the global ambient light model
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, globalAmb);
	glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER, GL_TRUE);
}

/// <summary>
/// Draws the scene each time it is called
/// </summary>
/// <param name=""></param>
void drawScene(void)
{
	// Set the material property values of the teapot
	float teapotAmb[] = { 0.9, 0.2, 0.2, 1.0 };
	float teapotDif[] = { 0.9, 0.2, 0.2, 1.0 };
	float teapotSpec[] = { 1.0, 1.0, 1.0, 1.0 };
	float teapotShine[] = { shine };

	// Redefine the light properties, including position
	float diffuse[] = { dR, dG, dB, 1.0 };
	float specular[] = { sR, sG, sB, 1.0 };
	float lightPos1[] = { xPos1, yPos1, zPos1, 1.0 };
	float lightPos2[] = { xPos2, yPos2, zPos2, 1.0 };

	// Set the first light's position
	glLightfv(GL_LIGHT0, GL_POSITION, lightPos1);
	// Set the first light's new diffuse and specular components
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
	glLightfv(GL_LIGHT0, GL_SPECULAR, specular);

	// Display the second light if enabled by the user
	if (enableLight2) {
		glLightfv(GL_LIGHT1, GL_POSITION, lightPos2);
		glEnable(GL_LIGHT1);
	}
	else {
		glDisable(GL_LIGHT1);
	}

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();

	gluLookAt(0, 1.0, 3.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

	// Set the material properties of the teapot
	glMaterialfv(GL_FRONT, GL_AMBIENT, teapotAmb);
	glMaterialfv(GL_FRONT, GL_DIFFUSE, teapotDif);
	glMaterialfv(GL_FRONT, GL_SPECULAR, teapotSpec);
	glMaterialfv(GL_FRONT, GL_SHININESS, teapotShine);

	// Initialize a Utah Teapot
	glutSolidTeapot(1.0);

	glutSwapBuffers();
}

/// <summary>
/// Resizes the viewing window of the program
/// </summary>
/// <param name="w">Width of the window</param>
/// <param name="h">Height of the window</param>
void resize(int w, int h)
{
	glViewport(0, 0, w, h);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60.0, (float)w / (float)h, 1.0, 20.0);

	glMatrixMode(GL_MODELVIEW);
}

/// <summary>
/// Handles ASCII key inputs
/// </summary>
/// <param name="key">Char value of the key entered</param>
/// <param name="x"></param>
/// <param name="y"></param>
void keyInput(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 27:
		exit(0);
		break;
	case 'd':
		// Toggle the first light's diffuse component
		if (enableLight2) break;
		if (!diffuseOn) {
			dR = 1.0;
			dG = 1.0;
			dB = 1.0;
			diffuseOn = true;
			glutPostRedisplay();
			break;
		}
		dR = 0.0;
		dG = 0.0;
		dB = 0.0;
		diffuseOn = false;
		glutPostRedisplay();
		break;
	case 's':
		// Toggle the first component's specular component
		if (enableLight2) break;
		if (!specularOn) {
			sR = 1.0;
			sG = 1.0;
			sB = 1.0;
			specularOn = true;
			glutPostRedisplay();
			break;
		}
		sR = 0.0;
		sG = 0.0;
		sB = 0.0;
		specularOn = false;
		glutPostRedisplay();
		break;
	case ',':
		// Move the selected light in the positive z direction
		if (enableLight2) {
			zPos2 += 0.5;
		}
		else {
			zPos1 += 0.5;
		}
		glutPostRedisplay();
		break;
	case '.':
		// Move the selected light in the negative z direction
		if (enableLight2) {
			zPos2 -= 0.5;
		}
		else {
			zPos1 -= 0.5;
		}
		glutPostRedisplay();
		break;
	case '+':
		// Increase the teapot's shine factor
		shine += 5.0;
		glutPostRedisplay();
		break;
	case '-':
		// Decrease the teapot's shine factor
		shine -= 5.0;
		glutPostRedisplay();
		break;
	case '2':
		// Enable or disable the second light
		enableLight2 = !enableLight2;
		glutPostRedisplay();
		break;
	default:
		break;
	}
}

/// <summary>
/// Handles "special" key inputs
/// </summary>
/// <param name="key">Value of the key pressed</param>
/// <param name="x"></param>
/// <param name="y"></param>
void specialKeyInput(int key, int x, int y) {
	if (key == GLUT_KEY_UP) {
		// Move the selected light upward
		if (enableLight2) {
			yPos2 += 0.5;
		}
		else {
			yPos1 += 0.5;
		}
	}
	if (key == GLUT_KEY_DOWN) {
		// Move the selected light downward
		if (enableLight2) {
			yPos2 -= 0.5;
		}
		else {
			yPos1 -= 0.5;
		}
	}
	if (key == GLUT_KEY_LEFT) {
		// Move the selected light to the left
		if (enableLight2) {
			xPos2 -= 0.5;
		}
		else {
			xPos1 -= 0.5;
		}
	}
	if (key == GLUT_KEY_RIGHT) {
		// Move the selected light to the right
		if (enableLight2) {
			xPos2 += 0.5;
		}
		else {
			xPos1 += 0.5;
		}
	}
	glutPostRedisplay();
}

/// <summary>
/// Prints all available user interactions to the console
/// </summary>
/// <param name=""></param>
void printInteraction(void)
{
	std::cout << "Programming Assignment 4\nimplemented by Cameron Howell" << std::endl;
	std::cout << "\nInstructions: Use the keys in the table below to control the lighting of the graphical environment" << std::endl;
	std::cout << "\n\nKey\tFunction" << std::endl;
	std::cout << "UP\tMove the light upward" << std::endl;
	std::cout << "DOWN\tMove the light downward" << std::endl;
	std::cout << "LEFT\tMove the light to the left" << std::endl;
	std::cout << "RIGHT\tMove the light to the right" << std::endl;
	std::cout << ",\tMove the light in the positive z direction" << std::endl;
	std::cout << ".\tMove the light in the negative z direction" << std::endl;
	std::cout << "s\tToggle the specular light component" << std::endl;
	std::cout << "d\tToggle the diffuse light component" << std::endl;
	std::cout << "+\tIncrease the shininess value of the teapot" << std::endl;
	std::cout << "-\tDecrease the shininess value of the teapot" << std::endl;
	std::cout << "2\tToggle a second light source" << std::endl;
}

/// <summary>
/// Main function that initializes the program
/// </summary>
/// <param name="argc">Number of arguments passed</param>
/// <param name="argv">The arguments passed</param>
/// <returns>integer on program success</returns>
int main(int argc, char** argv)
{
	printInteraction();
	glutInit(&argc, argv);

	glutInitContextVersion(4, 3);
	glutInitContextProfile(GLUT_COMPATIBILITY_PROFILE);

	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);

	glutInitWindowSize(500, 500);
	glutInitWindowPosition(100, 100);

	glutCreateWindow("Utah Teapot");

	glutDisplayFunc(drawScene);
	glutReshapeFunc(resize);
	glutKeyboardFunc(keyInput);
	glutSpecialFunc(specialKeyInput);

	glewExperimental = GL_TRUE;
	glewInit();

	setup();

	glutMainLoop();
}