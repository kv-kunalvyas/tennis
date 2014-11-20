/*
 * App.hpp
 *
 *  Created on: 1-mei-2012
 *      Author: stefan
 */

#ifndef APP_HPP_
#define APP_HPP_

#include "main.h"
#include "balltracking/balltracker.h"
#include "State.hpp"
#include "World.hpp"

namespace capselchi {/// Test settings. Some can be controlled in the GUI.

	class App {
		public:
			static int run(Settings* settings);
			/*
			 * @author Bart Bottu, Stefan Diels, Koen Van den Dries
			 * A class that contains the game loop and game initialization. It also
			 * processes user input in the form of a BallTracker.
			 */
			static void Resize(int w, int h);
			static void render();
			//static b2Vec2 ConvertScreenToWorld(int32 x, int32 y);
			static void Timer(int);
			static void Keyboard(unsigned char key, int x, int y);
			//static void KeyboardUp(unsigned char key, int x, int y);
			//static void KeyboardSpecial(int key, int x, int y);
			//static void Mouse(int button, int state, int x, int y);
			//static void MouseMotion(int x, int y);
			//static void MouseWheel(int wheel, int direction, int x, int y);
			static void Restart(int);
			static void Pause(int);
			static void Exit(int code);
			static void SingleStep(int);
			static void Step();
			static void calibrate();
			static void scanBalls();

			static void setBallTracker(BallTracker* bt);
			static void setWorld(World* w);
			static void setState(State* bt);
			//TODO calibratie van radiusfactor
			static float32 radiusFactor;

			/*
			 * Initialize game
			 */
		protected:
			static void init(void);
			/*
			 * run game until end conditions are met
			 * process input, generate output
			 */
			static void loop(void);
			/*
			 * cleanup after game ends
			 */
			static void cleanup(void);

		private:
			static BallTracker* ballTracker;
			static World* world;
			static State* state;
			static Settings* settings;
			static Ball* getBall(list<Ball*> balls, string color);

	};

} // namespace capselchi

#endif /* APP_HPP_ */
