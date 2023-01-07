module Rover
  class Ore
    getter x : Int32
    getter y : Int32
    getter animations

    Sheet = "./assets/ore.png"

    def initialize(x = 0, y = 0)
      # sprite size
      size = 64
      @x = x
      @y = y

      # init animations
      fps = 60

      # idle
      idle = GSF::Animation.new((fps / 3).to_i, loops: false)
      idle.add(Sheet, 0, 0, size, size)

      @animations = GSF::Animations.new(:idle, idle)
    end

    def update(frame_time)
      animations.update(frame_time)
    end

    def move(dx : Float64, dy : Float64)
      @x += dx
      @y += dy
    end

    def draw(window : SF::RenderWindow)
      animations.draw(window, x, y)
    end
  end
end
