module Rover
  class Ground
    getter x : Int32
    getter y : Int32

    def initialize(x = 0, y = 0)
      @x = x
      @y = y
    end

    def update(frame_time, keys : Keys)

    end

    def draw(window : SF::RenderWindow)

    end
  end
end
