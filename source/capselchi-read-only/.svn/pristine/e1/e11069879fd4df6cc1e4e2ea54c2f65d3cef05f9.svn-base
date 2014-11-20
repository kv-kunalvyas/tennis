/*
* Copyright (c) 2006-2009 Erin Catto http://www.box2d.org
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

#include "../Framework/Test.h"
#include "../Framework/Render.h"

#ifdef __APPLE__
	#include <GLUT/glut.h>
#else
	#include <GL/freeglut.h>
#endif

#include <cstring>
using namespace std;

#include "Balance.h"
#include "Unused/AddPair.h"
#include "Unused/ApplyForce.h"
#include "Unused/BodyTypes.h"
#include "Unused/Breakable.h"
#include "Unused/Bridge.h"
#include "Unused/BulletTest.h"
#include "Unused/Cantilever.h"
#include "Unused/Car.h"
#include "Unused/ContinuousTest.h"
#include "Unused/Chain.h"
#include "Unused/CharacterCollision.h"
#include "Unused/CollisionFiltering.h"
#include "Unused/CollisionProcessing.h"
#include "Unused/CompoundShapes.h"
#include "Unused/Confined.h"
#include "Unused/DistanceTest.h"
#include "Unused/Dominos.h"
#include "Unused/DumpShell.h"
#include "Unused/DynamicTreeTest.h"
#include "Unused/EdgeShapes.h"
#include "Unused/EdgeTest.h"
#include "Unused/Gears.h"
#include "Unused/OneSidedPlatform.h"
#include "Unused/Pinball.h"
#include "Unused/PolyCollision.h"
#include "Unused/PolyShapes.h"
#include "Unused/Prismatic.h"
#include "Unused/Pulleys.h"
#include "Unused/Pyramid.h"
#include "Unused/RayCast.h"
#include "Unused/Revolute.h"
//#include "Unused/Rope.h"
#include "Unused/RopeJoint.h"
#include "Unused/SensorTest.h"
#include "Unused/ShapeEditing.h"
#include "Unused/SliderCrank.h"
#include "Unused/SphereStack.h"
#include "Unused/TheoJansen.h"
#include "Unused/Tiles.h"
#include "Unused/TimeOfImpact.h"
#include "Unused/Tumbler.h"
#include "Unused/VaryingFriction.h"
#include "Unused/VaryingRestitution.h"
#include "Unused/VerticalStack.h"
#include "Unused/Web.h"

TestEntry g_testEntries[] =
{
	{"Balance", Balance::Create},
//	{"Tumbler", Tumbler::Create},
//	{"Tiles", Tiles::Create},
//	{"Dump Shell", DumpShell::Create},
//	{"Gears", Gears::Create},
//	{"Cantilever", Cantilever::Create},
//	{"Varying Restitution", VaryingRestitution::Create},
//	{"Character Collision", CharacterCollision::Create},
//	{"Edge Test", EdgeTest::Create},
//	{"Body Types", BodyTypes::Create},
//	{"Shape Editing", ShapeEditing::Create},
//	{"Car", Car::Create},
//	{"Apply Force", ApplyForce::Create},
//	{"Prismatic", Prismatic::Create},
//	{"Vertical Stack", VerticalStack::Create},
//	{"SphereStack", SphereStack::Create},
//	{"Revolute", Revolute::Create},
//	{"Pulleys", Pulleys::Create},
//	{"Polygon Shapes", PolyShapes::Create},
//	//{"Rope", Rope::Create},
//	{"Web", Web::Create},
//	{"RopeJoint", RopeJoint::Create},
//	{"One-Sided Platform", OneSidedPlatform::Create},
//	{"Pinball", Pinball::Create},
//	{"Bullet Test", BulletTest::Create},
//	{"Continuous Test", ContinuousTest::Create},
//	{"Time of Impact", TimeOfImpact::Create},
//	{"Ray-Cast", RayCast::Create},
//	{"Confined", Confined::Create},
//	{"Pyramid", Pyramid::Create},
//	{"Theo Jansen's Walker", TheoJansen::Create},
//	{"Edge Shapes", EdgeShapes::Create},
//	{"PolyCollision", PolyCollision::Create},
//	{"Bridge", Bridge::Create},
//	{"Breakable", Breakable::Create},
//	{"Chain", Chain::Create},
	{"Collision Filtering", CollisionFiltering::Create},
	{"Collision Processing", CollisionProcessing::Create},
//	{"Compound Shapes", CompoundShapes::Create},
//	{"Distance Test", DistanceTest::Create},
//	{"Dominos", Dominos::Create},
//	{"Dynamic Tree", DynamicTreeTest::Create},
	{"Sensor Test", SensorTest::Create},
//	{"Slider Crank", SliderCrank::Create},
//	{"Varying Friction", VaryingFriction::Create},
//	{"Add Pair Stress Test", AddPair::Create},
	{NULL, NULL}
};
