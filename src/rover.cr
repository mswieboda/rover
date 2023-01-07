require "game_sf"

require "./rover/game"

module Rover
  alias Keys = GSF::Keys
  alias Mouse = GSF::Mouse
  alias Joysticks = GSF::Joysticks

  Game.new.run
end
