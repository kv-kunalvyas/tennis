/*
 * Weight.cpp
 *
 *  Created on: 29-mei-2012
 *      Author: stefan
 */

#include "Weight.hpp"

namespace capselchi {

	Weight::Weight(World* world, b2Vec2 position, float32 weight, b2BodyDef def) {
		this->position = position;
		this->weight = weight;
		def.userData = this;
		def.type = b2_dynamicBody;
		this->world = world;
		this->body = world->createBody(&def);
		b2CircleShape shape;
		shape.m_radius = 1.5f;
		shape.m_p = position;
		b2FixtureDef fDef;
		fDef.shape = &shape;
		fDef.density = 15.0f;
		fDef.friction=1.0f;
		this->body->CreateFixture(&fDef, b2Color(0.1f,0.5f,0.9f));
		this->world->createWeight(this);
	}

	Weight::~Weight() {

	}

	b2Vec2 Weight::getPosition() {
		return position;
	}

	float32 Weight::getWeight() {
		return weight;
	}

	Body* Weight::getBody() {
		return body;
	}

} // namespace capselchi


