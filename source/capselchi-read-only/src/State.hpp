/*
 * State.hpp
 *
 *  Created on: 21-mei-2012
 *      Author: stefan
 */

#ifndef STATE_HPP_
#define STATE_HPP_
#include "main.h"
#include "World.hpp"

namespace capselchi {
	/*
	 * @author Bart Bottu, Stefan Diels, Koen Van den dries
	 * This class contains the game state at the start of each level and
	 * provides an iterator over game states for each level.
	 * use config file for world details.
	 */
	class State {
		public:
			State(void);
			World* currentWorld();
			World* nextWorld();

		private:
			World* world;
	};

} // namespace capselchi


#endif /* STATE_HPP_ */
