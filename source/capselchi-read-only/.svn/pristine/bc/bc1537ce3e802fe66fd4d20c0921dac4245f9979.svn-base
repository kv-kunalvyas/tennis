/*
 * Balloon.hpp
 *
 *  Created on: 1-mei-2012
 *      Author: stefan
 */

#ifndef BALLOON_HPP_
#define BALLOON_HPP_

#include "main.h"
#include <string>
#include "World.hpp"
#include "Actor.hpp"
#include "Body.h"

namespace capselchi {

	class World;


	struct calibPoint{
			float32 x,y,r;
	};
	/**
	 *
	 */
	class Balloon: public Actor {
		public:
			Balloon(World* world, string colorName, float32 x, float32 y, float32 r, Body* seesaw, b2FixtureDef* fixDef);
			~Balloon();
			float32 getPosition();
			float32 getWeight();
			Body* getSeeSaw();
			string getColor();
			void setPosition(float32 x, float32 y, float32 r);
			int isColor(string colorName);
			//TODO modify body with modification of position and radius

		private:
			World* world;
			string colorName;
			float32 position;
			float32 weight;
			Body* seesaw;
			Fixture* fixture;
			static calibPoint frontLeft, backRight;

	};

} // namespace capselchi

#endif /* BALLOON_HPP_ */
