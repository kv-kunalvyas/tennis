/*
* Copyright (c) 2011 Erin Catto http://www.box2d.org
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

#ifndef BALANCE_TEST_H
#define BALANCE_TEST_H

#include <math.h>
#include <iostream>
#define Pi 3.14159265358979f


class Balance : public Test
{
public:

	enum
	{
		e_count = 100
	};

	Balance()
	{
		ground = NULL;
		{
			b2BodyDef bd;
			ground = m_world->CreateBody(&bd);
		}

		{
			b2BodyDef bdBalance;
			bdBalance.type = b2_dynamicBody;
			bdBalance.allowSleep = false;
			bdBalance.position.Set(0.0f, 10.0f);
			balance = m_world->CreateBody(&bdBalance);

			b2PolygonShape shapeBalance;
			b2FixtureDef fdBalance;
			
			shapeBalance.SetAsBox(0.5f, 2.0f, b2Vec2( 10.0f, 0.0f), 0.0);
			fdBalance.shape = &shapeBalance;
			fdBalance.density = 0.0f;
			fdBalance.restitution = 0.0f;
			balance->CreateFixture(&fdBalance);
			shapeBalance.SetAsBox(0.5f, 2.0f, b2Vec2(-10.0f, 0.0f), 0.0);
			fdBalance.shape = &shapeBalance;
			fdBalance.density = 0.0f;
			fdBalance.restitution = 0.0f;
			balance->CreateFixture(&fdBalance);
//			shape.SetAsBox(10.0f, 0.5f, b2Vec2(0.0f, 10.0f), 0.0);
//			fd.shape = &shape;
//			fd.density = 5.0f;
//			fd.restitution = 0.75f;
//			body->CreateFixture(&fd);
			shapeBalance.SetAsBox(10.0f, 0.5f, b2Vec2(0.0f, -3.0f), 0.0);
			fdBalance.shape = &shapeBalance;
			fdBalance.density = 5.0f;
			fdBalance.restitution = 0.0f;
			balance->CreateFixture(&fdBalance);

			b2RevoluteJointDef jdRev;
			jdRev.bodyA = ground;
			jdRev.bodyB = balance;
			jdRev.localAnchorA.Set(0.0f, 10.0f);
			jdRev.localAnchorB.Set(0.0f, 0.0f);
			jdRev.referenceAngle = 0.0f;
			jdRev.motorSpeed = 0.05f * b2_pi;
			jdRev.maxMotorTorque = 1e8f;
			jdRev.enableMotor = !true;
			m_joint = (b2RevoluteJoint*)m_world->CreateJoint(&jdRev);

//			b2BodyDef bdWeight;
//			bdWeight.type = b2_dynamicBody;
//			bdWeight.position.Set(0.0f, 10.0f);
//			weight = m_world->CreateBody(&bdWeight);

			b2CircleShape shapeWeight;
			shapeWeight.m_radius = 1.f;
			shapeWeight.m_p = b2Vec2(0.0f,-1.5f);

//			b2FixtureDef fdWeight;
//			fdWeight.shape = &shapeWeight;
//			fdWeight.density = .75f;
//
//			fdWeight.restitution = 0.f;

			weightFixture =  balance->CreateFixture(&shapeWeight,7.75f);



		}

		m_count = 0;
	}

	void Step(Settings* settings) {
			Test::Step(settings);

//			if (m_count < e_count) {
//
//				b2CircleShape shape;
//				shape.m_radius = 0.125f;
//				shape.m_p = b2Vec2(5.0f*std::sin(float(m_count)/float(e_count)*2*Pi), 5.0f*std::cos(float(m_count)/float(e_count)*2*Pi));
//
//				b2FixtureDef fd;
//				fd.shape = &shape;
//				fd.density = .75f;
//
//				fd.restitution = 0.f;
//
//				weight->CreateFixture(&fd);
//
//				++m_count;
//				std::cout<<float(m_count)/float(e_count)<<std::endl;
//			}
			balance->DestroyFixture(weightFixture);
			b2CircleShape shapeWeight;
			shapeWeight.m_radius = 1.f;
			shapeWeight.m_p = b2Vec2(8.0f*std::sin(m_count/400.f*2*Pi)*std::cos(m_count/1000.f*2*Pi),-1.5f);
			weightFixture = balance->CreateFixture(&shapeWeight,7.75f);
			++m_count;
		}

	static Test* Create()
	{
		return new Balance;
	}

	b2Fixture* weightFixture;
//	b2Body* weight;
	b2Body* ground;
	b2Body* balance;
	b2RevoluteJoint* m_joint;
	int32 m_count;
};

#endif
