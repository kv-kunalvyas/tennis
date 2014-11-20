/*
 * Balloon.cpp
 *
 *  Created on: 1-mei-2012
 *      Author: stefan
 */
#include <stddef.h>
#include <assert.h>
#include "Balloon.hpp"
namespace capselchi {

	Balloon::Balloon(World *world, string colorName, float32 x, float32 y, float32 r, Body *seesaw, b2FixtureDef *fixDef) {
		this->setPosition(x, y, r);
		this->colorName = colorName;
		this->world = world;
		this->seesaw = seesaw;
		this->world->createBall(this);
	}

	Balloon::~Balloon() {
		seesaw->getBody()->SetUserData(NULL);
		world->removeBall(this);
		world->destroyBody(seesaw);
	}

	float32 Balloon::getPosition() {
		return position;
	}

	float32 Balloon::getWeight() {
		return weight;
	}

	Body* Balloon::getSeeSaw() {
		return seesaw;
	}

	string Balloon::getColor() {
		return colorName;
	}

	void Balloon::setPosition(float32 x, float32 y, float32 r) {
	}

	int Balloon::isColor(string colorName) {
		return this->colorName.compare(colorName);
	}

} // namespace capselchi


