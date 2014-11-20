/*
 * Fixture.cpp
 *
 *  Created on: May 30, 2012
 *      Author: koen
 */

#include "Fixture.h"

namespace capselchi {

	Fixture::Fixture(b2Fixture* fixture, b2Color color) {
		this->fixture = fixture;
		this->color = color;
	}

	Fixture::~Fixture() {
		fixture = 0;
		parentBody = 0;
	}

	b2Body *Fixture::getParent() {
		return parentBody;
	}

	b2Fixture *Fixture::getFixture() {
		return fixture;
	}

	b2Color Fixture::getColor() {
		return color;
	}

}
