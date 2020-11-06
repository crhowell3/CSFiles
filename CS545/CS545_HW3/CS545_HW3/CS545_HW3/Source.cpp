/**
 * Author: Cameron Howell
 * Class: CS545 Fall 2020
 * Due Date: November 1, 2020 11:59PM
 * Assignment: Program 3
 * Description: Drawing program in which user can move a "brush"
 * and draw using one of three available brush shape options
 */

#include <cstdlib>
#include <cmath>
#include <iostream>
#include <ctime>
#include <vector>
#include <string>
#include <GL/glew.h>
#include <GL/freeglut.h>

// Times New Roman font for the display text
static long font = (long)GLUT_BITMAP_TIMES_ROMAN_24;
// Initial location for the cursor
static float point_x = 0.0, point_y = 0.0;
// Name of the current brush
static std::string brush_name;
// Integer flag that decides what shape is drawn
static int brush_setting = 1;
// Boolean to trigger drawing
static bool toggle_face = false;
// Boolean to toggle live cursor
static bool live_cursor = false;

//
/* Class and member functions for defining the Cube object */
//
class Cube {
public:
	Cube(float x, float y);
	void setColor(float r, float g, float b);
	void draw();
private:
	float x_val, y_val;
	float cube_color[3];
};

Cube::Cube(float x, float y) {
	x_val = x;
	y_val = y;
	cube_color[0] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
	cube_color[1] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
	cube_color[2] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
}

void Cube::setColor(float r, float g, float b) {
	cube_color[0] = r;
	cube_color[1] = g;
	cube_color[2] = b;
}

void Cube::draw() {
	glPushMatrix();
	glTranslatef(x_val, y_val, -50.0);
	glColor3f(cube_color[0], cube_color[1], cube_color[2]);
	glutWireCube(5.0);
	glPopMatrix();
}

//
/* Class and member functions for defining the Sphere object */
//
class Sphere {
public:
	Sphere(float x, float y);
	void setColor(float r, float g, float b);
	void draw();
private:
	float x_val, y_val;
	float sphere_color[3];
};

Sphere::Sphere(float x, float y) {
	x_val = x;
	y_val = y;
	sphere_color[0] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
	sphere_color[1] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
	sphere_color[2] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
}

void Sphere::setColor(float r, float g, float b) {
	sphere_color[0] = r;
	sphere_color[1] = g;
	sphere_color[2] = b;
}

void Sphere::draw() {
	glPushMatrix();
	glTranslatef(x_val, y_val, -50.0);
	glColor3f(sphere_color[0], sphere_color[1], sphere_color[2]);
	glutWireSphere(2.5, 8, 8);
	glPopMatrix();
}

//
/* Class and member functions for defining the Triangle object */
//
class Triangle {
public:
	Triangle(float x, float y);
	void setColor(float r, float g, float b);
	void draw();
private:
	float cursor_x, cursor_y;
	float triangle_color[3];
};

Triangle::Triangle(float x, float y) {
	// Cursor position at time of drawing
	cursor_x = x;
	cursor_y = y;

	triangle_color[0] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
	triangle_color[1] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
	triangle_color[2] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
}

void Triangle::setColor(float r, float g, float b) {
	triangle_color[0] = r;
	triangle_color[1] = g;
	triangle_color[2] = b;
}

void Triangle::draw() {
	glPushMatrix();
	glTranslatef(cursor_x, cursor_y, -50.0);
	glColor3f(triangle_color[0], triangle_color[1], triangle_color[2]);
	glBegin(GL_TRIANGLES);
		glVertex3f(0.0, 2.5, 0.0);
		glVertex3f(-2.5, -2.5, 0.0);
		glVertex3f(2.5, -2.5, 0.0);
	glEnd();
	glPopMatrix();
}

//
/* Object vectors to maintain position and color of all currently drawn shapes */
//
std::vector<Cube> current_cubes;
std::vector<Sphere> current_spheres;
std::vector<Triangle> current_triangles;

void writeBitmapString(void* font, char* string) {
	char* c;

	for (c = string; *c != '\0'; c++) glutBitmapCharacter(font, *c);
}

void drawScene(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glLoadIdentity();

	// Draw the cursor
	if (!live_cursor) {
		glPushMatrix();
		glColor3f(0.0, 0.0, 0.0);
		glPointSize(5.0);
		glBegin(GL_POINTS);
		glVertex3f(point_x, point_y, -50.0);
		glEnd();
		glPopMatrix();
	}
	else {
		glPushMatrix();
		if (brush_setting == 1) {
			Cube cube(point_x, point_y);
			cube.setColor(0.0, 0.0, 0.0);
			cube.draw();
		}
		else if (brush_setting == 2) {
			Sphere sphere(point_x, point_y);
			sphere.setColor(0.0, 0.0, 0.0);
			sphere.draw();
		}
		else if (brush_setting == 3) {
			Triangle triangle(point_x, point_y);
			triangle.setColor(0.0, 0.0, 0.0);
			triangle.draw();
		}
		glPopMatrix();
	}
	// Determine which primitive is in use
	if (brush_setting == 1) {
		brush_name = "Cube";
	}
	else if (brush_setting == 2) {
		brush_name = "Sphere";
	}
	else if (brush_setting == 3) {
		brush_name = "Triangle";
	}

	// Draw text indicating brush primitive
	glPushMatrix();
		glColor3f(0.0, 0.0, 0.0);
		glRasterPos3f(-50.0, -48.0, -50.0);
		writeBitmapString((void*)font, (char*)("Brush: " + brush_name).c_str());
	glPopMatrix();

	// Redraw all cubes in vector
	if (!current_cubes.empty()) {
		for (Cube& c : current_cubes){
			c.draw();
		}
	}

	// Redraw all spheres in vector
	if (!current_spheres.empty()) {
		for (Sphere& s : current_spheres) {
			s.draw();
		}
	}

	// Redraw all triangles in vector
	if (!current_triangles.empty()) {
		for (Triangle& t : current_triangles) {
			t.draw();
		}
	}

	glFlush();
}

void setup(void)
{
	glPolygonMode(GL_FRONT, GL_LINE);
	glPolygonMode(GL_BACK, GL_FILL);

	// Seeding for srand
	srand(static_cast <unsigned> (time(0)));

	glClearColor(1.0, 1.0, 1.0, 0.0);
}


void resize(int w, int h)
{
	glViewport(0, 0, w, h);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(90, 1.0, 5.0, 100.0);

	glMatrixMode(GL_MODELVIEW);
}

void keyInput(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 27:
		exit(0);
		break;
	// Draw the currently selected brush object at the cursor location
	case ' ':
		if (brush_setting == 1) {
			current_cubes.push_back(Cube(point_x, point_y));
		}
		else if (brush_setting == 2) {
			current_spheres.push_back(Sphere(point_x, point_y));
		}
		else if (brush_setting == 3) {
			current_triangles.push_back(Triangle(point_x, point_y));
		}
		glutPostRedisplay();
		break;
	// Move the cursor up 5 units
	case 'w':
		point_y += 5.0;
		glutPostRedisplay();
		break;
	// Move the cursor down 5 units
	case 's':
		point_y -= 5.0;
		glutPostRedisplay();
		break;
	// Move the cursor left 5 units
	case 'a':
		point_x -= 5.0;
		glutPostRedisplay();
		break;
	// Move the cursor right 5 units
	case 'd':
		point_x += 5.0;
		glutPostRedisplay();
		break;
	// Cycle to the next primitive
	case '+':
		brush_setting++;
		if (brush_setting > 3) {
			brush_setting = 1;
		}
		glutPostRedisplay();
		break;
	// Cycle to the previous primitive
	case '-':
		brush_setting--;
		if (brush_setting < 1) {
			brush_setting = 3;
		}
		glutPostRedisplay();
		break;
	// Toggle glFrontFace between CCW and CW
	case 'o':
		toggle_face = !toggle_face;
		if (!toggle_face) {
			glFrontFace(GL_CCW);
		}
		else {
			glFrontFace(GL_CW);
		}
		glutPostRedisplay();
		break;
	case 'l':
		live_cursor = !live_cursor;
		glutPostRedisplay();
		break;
	case 'r':
		current_cubes.clear();
		current_spheres.clear();
		current_triangles.clear();
		glutPostRedisplay();
		break;
	default:
		break;
	}
}

void printInteraction(void)
{
	std::cout << "Programming Assignment 3\nimplemented by Cameron Howell" << std::endl;
	std::cout << "\nInstructions: Use the keys in the table below to control the drawing program" << std::endl;
	std::cout << "\n\nKey\tFunction" << std::endl;
	std::cout << "SPACE\tDraw at the location of the cursor" << std::endl;
	std::cout << "w\tMove cursor up 5 units" << std::endl;
	std::cout << "s\tMove cursor down 5 units" << std::endl;
	std::cout << "a\tMove cursor left 5 units" << std::endl;
	std::cout << "d\tMove cursor right 5 units" << std::endl;
	std::cout << "+\tCycle to next primitive" << std::endl;
	std::cout << "-\tCycle to previous primitive" << std::endl;
	std::cout << "o\tToggle between CW and CCW front face" << std::endl;
	std::cout << "l\tToggle live brush option" << std::endl;
	std::cout << "r\tRemove all shapes from the screen" << std::endl;
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

	glutCreateWindow("Drawing App");

	glutDisplayFunc(drawScene);
	glutReshapeFunc(resize);
	glutKeyboardFunc(keyInput);

	glewExperimental = GL_TRUE;
	glewInit();

	setup();

	glutMainLoop();
}