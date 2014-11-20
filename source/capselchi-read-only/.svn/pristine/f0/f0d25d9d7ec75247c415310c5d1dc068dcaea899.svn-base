/*
 * main.cpp
 *
 *  Created on: 1-mei-2012
 *      Author: stefan
 */

#include "main.h"

#include <iostream>

#include <assert.h>
#include <stddef.h>
#include "App.hpp"
#include "World.hpp"
using namespace capselchi;

int main(int argc, char **argv) {
	Settings* settings = new Settings();
	cout<<"Beginning"<<endl;

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_MULTISAMPLE);
	glutInitWindowSize(settings->width, settings->height);
	cout<<settings->mainWindow<<endl;
	settings->mainWindow = 10;
	cout<<settings->mainWindow<<endl;
	settings->mainWindow = glutCreateWindow("Balance");
	cout<<settings->mainWindow<<endl;
	glutSetOption(GLUT_ACTION_ON_WINDOW_CLOSE, GLUT_ACTION_GLUTMAINLOOP_RETURNS);
	glutSetOption(GLUT_MULTISAMPLE, 8);
	cout<<settings->mainWindow<<endl;
	VideoCapture capture;
	capture.open(0);
	list<string> colorNames;
	colorNames.push_back("Yellow");
	colorNames.push_back("Red");

	App::setBallTracker(new BallTracker(capture,colorNames));



	App::setWorld(new World(settings));
	App::run(settings);
	cout<<"Ending"<<endl;
	return 0;
}
