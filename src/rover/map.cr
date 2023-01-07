require "./ore"
require "./rover"
require "./player"

module Rover
  class Map
    getter x : Int32
    getter y : Int32
    # getter player
    getter rover
    getter ore

    def initialize(x = 0, y = 0)
      @x = x
      @y = y

      @rover = Rover.new(x: 300, y: 300)
      @ore = Ore.new(x: 500, y: 500)
    end

    def update(frame_time, keys : Keys)
      # player.update(frame_time, keys)
      rover.update(frame_time, keys)
      ore.update(frame_time)
    end

    def draw(window : SF::RenderWindow)
      ore.draw(window)
      # player.draw(window)
      rover.draw(window)
    end
  end
end
