/*
 * App.cpp
 *
 *  Created on: 1-mei-2012
 *      Author: stefan
 */

#include <assert.h>
#include <stddef.h>
#include "App.hpp"
#include "Render.h"

namespace capselchi {

	Settings* App::settings = NULL;
	//TODO game loop
	int App::run(Settings* settings) {
		App::settings = settings;
		init();
		cout << "Beginning2" << endl;
		loop();
		cout << "Beginning3" << endl;
		cleanup();
		cout << "Beginning4" << endl;
		return 0;
	}

	void App::init(void) {
		cout << settings->mainWindow << endl;
		glutDisplayFunc(App::render);
		GLUI_Master.set_glutReshapeFunc(App::Resize);
		GLUI_Master.set_glutKeyboardFunc(App::Keyboard);
		//		GLUI_Master.set_glutMouseFunc(Mouse);
		//		glutMotionFunc(MouseMotion);
		//		glutKeyboardUpFunc(KeyboardUp);
		settings->glui = GLUI_Master.create_glui_subwindow(settings->mainWindow, GLUI_SUBWINDOW_RIGHT );
		settings->glui->add_separator();
		GLUI_Spinner* velocityIterationSpinner = settings->glui->add_spinner("Vel Iters", GLUI_SPINNER_INT,
				&(settings->velocityIterations));
		velocityIterationSpinner->set_int_limits(1, 500);
		GLUI_Spinner* positionIterationSpinner = settings->glui->add_spinner("Pos Iters", GLUI_SPINNER_INT,
				&(settings->positionIterations));
		positionIterationSpinner->set_int_limits(0, 100);
		GLUI_Spinner* hertzSpinner = settings->glui->add_spinner("Hertz", GLUI_SPINNER_FLOAT, &(settings->settingsHz));
		hertzSpinner->set_float_limits(5.0f, 200.0f);
		GLUI_Spinner* fpsSpinner = settings->glui->add_spinner("FPS", GLUI_SPINNER_INT, &(settings->fps));
		fpsSpinner->set_int_limits(10, 120);
		settings->glui->add_button("Calibrate", 0,(GLUI_Update_CB) (calibrate));
		settings->glui->add_button("Pause", 0, Pause);
		settings->glui->add_button("Single Step", 0, SingleStep);
		settings->glui->add_button("Restart", 0, Restart);
		settings->glui->add_button("Quit", 0, (GLUI_Update_CB) (Exit));
		settings->glui->set_main_gfx_window(settings->mainWindow);
		glEnable(GL_MULTISAMPLE);

	}

	Ball* App::getBall(list<Ball*> balls, string color){
		Ball* ball = NULL;
		for(list<Ball*>::iterator it = balls.begin(); it!= balls.end(); it++){
			Ball* tmp = *it;
			string name = tmp->getColorName();
			if(name.compare(color)){
				if(ball == NULL || ball->getR()<tmp->getR())
					ball = tmp;
			}
		}
		return ball;
	}

	void App::loop(void) {
		//TODO game loop
		// Use a timer to control the frame rate.

		int32 framePeriod = 1000 / settings->fps;
		glutTimerFunc(framePeriod, Timer, 0);
		glutMainLoop();
	}

	void App::cleanup(void) {
	}

	void App::Resize(int w, int h) {
		settings->width = w;
		settings->height = h;

		GLUI_Master.get_viewport_area(&(settings->tx), &(settings->ty), &(settings->tw), &(settings->th));
		glViewport(settings->tx, settings->ty, settings->tw, settings->th);

		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		float32 ratio = float32(settings->tw) / float32(settings->th);

		b2Vec2 extents(ratio * 25.0f, 25.0f);

		b2Vec2 lower = settings->viewCenter - extents;
		b2Vec2 upper = settings->viewCenter + extents;


		// L/R/B/T
		gluOrtho2D(lower.x, upper.x, lower.y, upper.y);
	}


	//	b2Vec2 App::ConvertScreenToWorld(int32 x, int32 y) {
	//		float32 u = x / float32(tw);
	//			float32 v = (th - y) / float32(th);
	//
	//			float32 ratio = float32(tw) / float32(th);
	//			b2Vec2 extents(ratio * 25.0f, 25.0f);
	//			extents *= viewZoom;
	//
	//			b2Vec2 lower = settings.viewCenter - extents;
	//			b2Vec2 upper = settings.viewCenter + extents;
	//
	//			b2Vec2 p;
	//			p.x = (1.0f - u) * lower.x + u * upper.x;
	//			p.y = (1.0f - v) * lower.y + v * upper.y;
	//			return p;
	//	}

	void App::Keyboard(unsigned char key, int x, int y) {
		B2_NOT_USED(x);
		B2_NOT_USED(y);

		switch (key) {
			case 27:
#ifndef __APPLE__
				// freeglut specific function
				glutLeaveMainLoop();
#endif
				exit(0);
				break;

			case 'p':
				settings->pause = !settings->pause;
				break;
		}
	}


	//	void App::Mouse(int button, int state, int x, int y) {
	//		// Use the mouse to move things around.
	//		if (button == GLUT_LEFT_BUTTON)
	//		{
	//			int mod = glutGetModifiers();
	//			b2Vec2 p = ConvertScreenToWorld(x, y);
	//			if (state == GLUT_DOWN)
	//			{
	//				b2Vec2 p = ConvertScreenToWorld(x, y);
	//				if (mod == GLUT_ACTIVE_SHIFT)
	//				{
	//					test->ShiftMouseDown(p);
	//				}
	//				else
	//				{
	//					test->MouseDown(p);
	//				}
	//			}
	//
	//			if (state == GLUT_UP)
	//			{
	//				test->MouseUp(p);
	//			}
	//		}
	//		else if (button == GLUT_RIGHT_BUTTON)
	//		{
	//			if (state == GLUT_DOWN)
	//			{
	//				lastp = ConvertScreenToWorld(x, y);
	//				rMouseDown = true;
	//			}
	//
	//			if (state == GLUT_UP)
	//			{
	//				rMouseDown = false;
	//			}
	//		}
	//	}


	//	void App::MouseMotion(int32 x, int32 y)
	//	{
	//		b2Vec2 p = ConvertScreenToWorld(x, y);
	//		test->MouseMove(p);
	//
	//		if (rMouseDown)
	//		{
	//			b2Vec2 diff = p - lastp;
	//			settings.viewCenter.x -= diff.x;
	//			settings.viewCenter.y -= diff.y;
	//			Resize(width, height);
	//			lastp = ConvertScreenToWorld(x, y);
	//		}
	//	}

	void App::Timer(int value) {
		int32 framePeriod = 1000 / settings->fps;
		glutTimerFunc(framePeriod, Timer, 0);
		App::scanBalls();

		App::Step();
		App::Step();
		glutPostWindowRedisplay(settings->mainWindow);

	}

	void App::render() {
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		Render::DrawBodies(world->getBodyList());

		glutSwapBuffers();
	}

	void App::Restart(int) {
		Resize(settings->width, settings->height);
	}

	void App::Pause(int) {
		settings->pause = !settings->pause;
	}

	void App::Exit(int code) {
		// TODO: freeglut is not building on OSX
#ifdef FREEGLUT
		glutLeaveMainLoop();
#endif
		exit(code);
	}

	void App::SingleStep(int) {
		settings->pause = 1;
		settings->singleStep = 1;
	}

	BallTracker *App::ballTracker = NULL;
	World* App::world = NULL;
	State* App::state = NULL;

	void App::setBallTracker(BallTracker* bt) {
		ballTracker = bt;
	}
	void App::setWorld(World* w) {
		world = w;
	}
	void App::setState(State* bt) {
		state = bt;
	}

	void App::Step() {
		float32 timeStep = settings->settingsHz > 0.0f ? 1.0f / settings->settingsHz : float32(0.0f);

		if (settings->pause) {
			if (settings->singleStep) {
				settings->singleStep = 0;
			} else {
				timeStep = 0.0f;
			}
		}
		b2World* m_world = world->getWorld();
		m_world->SetWarmStarting(settings->enableWarmStarting > 0);
		m_world->SetContinuousPhysics(settings->enableContinuous > 0);
		m_world->SetSubStepping(settings->enableSubStepping > 0);
		m_world->Step(timeStep, settings->velocityIterations, settings->positionIterations);
	}

	void App::calibrate() {
		App::ballTracker->calibrate();

	}

	float App::radiusFactor = 1.0f;
	void App::scanBalls() {

		list<Ball*> balls = ballTracker->getBalls();
				list<string> colors = world->getColors();
				for(list<string>::iterator it = colors.begin(); it!=colors.end(); it++){
					string color = *it;
					Ball* bal = getBall(balls, color);
					Balloon* balloon = world->getBall(color);
					int x = bal->getX();
					int y = bal->getY();
					int r = bal->getR();
					int width = ballTracker->getFrameWidth();
					int heigth = ballTracker->getFrameHeight();
					float32 xpos = 1.0*x/width+ width*0.5;
					float32 ypos = 1.0*y/heigth;
					float32 radius = r*radiusFactor;
					balloon->setPosition(xpos, ypos,radius);
		}

	}

}
