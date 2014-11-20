/*
 * World.cpp
 *
 *  Created on: 21-mei-2012
 *      Author: stefan
 */
#include <assert.h>
#include <stddef.h>
#include "World.hpp"

/* WEIGHT_HPP_ */
/* WEIGHT_HPP_ */
namespace capselchi {
	World::World(Settings* settings) {
		this->settings = settings;
		b2Vec2 gravity;
		gravity.Set(0.0f, -settings->gravity);
		world = new b2World(gravity);
		b2BodyDef baseDef;
		baseDef.position.Set(0, 0);
		baseDef.type = b2_staticBody;
		base = this->createBody(&baseDef);
		//b2PolygonShape baseShape = b2PolygonShape.
		b2BodyDef seesawDef;
		seesawDef.position.Set(0, 20.f);
		seesawDef.type = b2_dynamicBody;
		seesaw = this->createBody(&seesawDef);
		b2PolygonShape seesawShape;
		b2FixtureDef seesawFD;
		b2Color seesawColor = b2Color(0.5f,0.9f,0.1f);

		seesawShape.SetAsBox(0.5f, 3.0f, b2Vec2(20.0f, -5.0f), 0.0);
		seesawFD.shape = &seesawShape;
		seesawFD.density = 0.0f;
		seesawFD.restitution = 0.0f;
		seesaw->CreateFixture(&seesawFD, seesawColor);
		seesawShape.SetAsBox(0.5f, 3.0f, b2Vec2(-20.0f, -5.0f), 0.0);
		seesawFD.shape = &seesawShape;
		seesawFD.density = 0.0f;
		seesawFD.restitution = 0.0f;
		seesaw->CreateFixture(&seesawFD, seesawColor);
		seesawShape.SetAsBox(20.0f, 0.5f, b2Vec2(0.0f, -3.0f), 0.0);
		seesawFD.shape = &seesawShape;
		seesawFD.density = 5.0f;
		seesawFD.restitution = 0.0f;
		seesaw->CreateFixture(&seesawFD, seesawColor);
		seesawShape.SetAsBox(20.0f, 0.5f, b2Vec2(0.0f, -8.0f), 0.0);
		seesawFD.shape = &seesawShape;
		seesawFD.density = 5.0f;
		seesawFD.restitution = 0.0f;
		seesaw->CreateFixture(&seesawFD, seesawColor);

		b2RevoluteJointDef jdRev;
		jdRev.bodyA = base->getBody();
		jdRev.bodyB = seesaw->getBody();
		jdRev.localAnchorA.Set(0.0f, 20.0f);
		jdRev.localAnchorB.Set(0.0f, 0.0f);
		jdRev.referenceAngle = 1.0f;
		jdRev.motorSpeed = 0.05f * b2_pi;
		jdRev.maxMotorTorque = 1e8f;
		jdRev.enableMotor = !true;
		joint = (b2RevoluteJoint*) world->CreateJoint(&jdRev);

		b2BodyDef weightDef;
		weightDef.position = b2Vec2(0.0f,20.0f);
		this->createWeight(new Weight(this,b2Vec2(5.0f,-6.0f),0,weightDef));
		weightDef.position = b2Vec2(0.0f,20.0f);
		this->createWeight(new Weight(this,b2Vec2(-3.0f,-6.0f),0,weightDef));
		weightDef.position = b2Vec2(0.0f,20.0f);
	}

	World::~World() {
		delete world;
	}

	void World::createBall(Balloon *balloon) {
		balloons.insert(pair<string, Balloon*> (balloon->getColor(), balloon));
		colors.push_back(balloon->getColor());
	}

	void World::removeBall(Balloon *balloon) {
		balloons.erase(balloon->getColor());
		colors.remove(balloon->getColor());
	}

	void World::createWeight(Weight *weight) {
		weights.push_back(weight->getBody());
		bodies.push_back(weight->getBody());
	}

	Balloon *World::getBall(string color) {
		return balloons[color];
	}

	Body *World::getWeight(int index) {
		return NULL;
	}

	void World::reset() {
	}

	Body *World::createBody(b2BodyDef *def) {
		Body *body = new Body(world->CreateBody(def));
		bodies.push_back(body);
		return body;
	}

	void World::destroyBody(Body *body) {
		bodies.remove(body);
		delete body;
		world->DestroyBody(body->getBody());
	}

	list<Body*> World::getBodyList() {
		return bodies;
	}

	b2World *World::getWorld(){
		return world;
	}

	list<string> World::getColors(){
		return colors;
	}

//TODO initialize seesaw and base
//TODO create fixtures with shapes;
//TODO joints
//TODO reset and destroy remaining artefacts
//TODO fixture & joint
//TODO get the ball at index location;
//TODO get weight at index location
//TODO reset world cleanup old world
} // namespace capselchi


