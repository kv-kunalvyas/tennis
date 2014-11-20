/*
 * Body.h
 *
 *  Created on: May 30, 2012
 *      Author: koen
 */

#ifndef BODY_H_
#define BODY_H_

#include "main.h"
#include <list>
#include "Fixture.h"

namespace capselchi {

	class Fixture;

	class Body {
		public:
			Body(b2Body* body);
			virtual ~Body();
			b2Body* getBody();
			list<Fixture*> getFixtureList();
			Fixture* CreateFixture(b2FixtureDef* fixDef, b2Color color);
			Fixture* CreateFixture(b2Shape* fixDef, float32 density, b2Color color);
			void DestroyFixture(Fixture* fixture);

		private:
			b2Body* body;
			list<Fixture*> fixtures;

	};

}

#endif /* BODY_H_ */
