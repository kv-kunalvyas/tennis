/*
 * main.h
 *
 *  Created on: May 30, 2012
 *      Author: koen
 */

#ifndef MAIN_H_
#define MAIN_H_

#include <Box2D/Box2D.h>
#include <GL/freeglut.h>
#include <GL/glui.h>
#include <opencv/cv.hpp>
#include <opencv/highgui.h>
#include <iostream>

using namespace std;

struct Settings {
		Settings() :
			viewCenter(0.0f, 20.0f), velocityIterations(8), positionIterations(3), enableWarmStarting(1),
					enableContinuous(0), enableSubStepping(0), pause(0), singleStep(0), gravity(9.81f), width(640),
					height(480), fps(30), settingsHz(60.f) {
		}

		b2Vec2 viewCenter;
		int velocityIterations;
		int positionIterations;
		int enableWarmStarting;
		int enableContinuous;
		int enableSubStepping;
		int pause;
		int singleStep;
		float gravity;
		int width;
		int height;
		int fps;
		int mainWindow;
		float settingsHz;
		GLUI *glui;
		int tx, ty, tw, th;
		bool rMouseDown;

};

#endif /* MAIN_H_ */
