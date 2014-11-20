/*
 * State.cpp
 *
 *  Created on: 21-mei-2012
 *      Author: stefan
 */

#include "State.hpp"
#include <assert.h>
#include <stddef.h>

namespace capselchi {

	State::State() {
		b2Vec2 gravity;
		gravity.Set(0.0f, -10.0f);
		//world = new b2World(gravity);
	}

	World *State::nextWorld() {
	}

	World *State::currentWorld() {
	}

} // namespace capselchi


