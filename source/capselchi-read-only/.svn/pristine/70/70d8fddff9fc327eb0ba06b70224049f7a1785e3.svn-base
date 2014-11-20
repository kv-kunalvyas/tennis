/*
 * World.hpp
 *
 *  Created on: 21-mei-2012
 *      Author: stefan
 */

#ifndef WORLD_HPP_
#define WORLD_HPP_

#include "main.h"
#include <list>
#include <map>
#include "Balloon.hpp"
#include "Weight.hpp"
#include "Body.h"
#include "Fixture.h"

namespace capselchi {
	class Balloon;
	class Weight;
	class World {
		public:
			World(Settings* settings);
			~World(void);
			void createBall(Balloon* balloon);
			void createWeight(Weight* weight);
			Balloon* getBall(string color);
			Body* getWeight(int index);
			void reset(void);
			Body* createBody(b2BodyDef* def);
			void removeBall(Balloon* balloon);
			void destroyBody(Body* body);
			list<Body*> getBodyList();
			b2World* getWorld();
			list<string> getColors();

		private:
			b2World* world;
			list<Body*> ballBodies;
			map<string,Balloon*> balloons;
			list<Body*> weights;
			Body* base;
			Body* seesaw;
			b2RevoluteJoint* joint;
			list<Body*> bodies;
			Settings* settings;
			list<string> colors;
	};

} // namespace capselchi


#endif /* WORLD_HPP_ */
