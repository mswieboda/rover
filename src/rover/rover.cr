module Rover
  class Rover
    getter x : Float64
    getter y : Float64
    getter animations

    Speed = 333
    Sheet = "./assets/player.png"

    def initialize(x = 0, y = 0)
      # sprite size
      size = 128
      @x = x
      @y = y

      # init animations
      fps = 60

      # idle
      idle = GSF::Animation.new((fps / 3).to_i, loops: false)
      idle.add(Sheet, 0, 0, size, size)

      # # fire animation
      # fire_frames = 3
      # fire = GSF::Animation.new((fps / 25).to_i, loops: false)

      # fire_frames.times do |i|
      #   fire.add(Sheet, i * size, 0, size, size)
      # end

      @animations = GSF::Animations.new(:idle, idle)
      # animations.add(:fire, fire)
    end

    def update(frame_time, keys : Keys)
      animations.update(frame_time)

      update_movement(frame_time, keys)
    end

    def update_movement(frame_time, keys : Keys)
      dx = 0_f64
      dy = 0_f64
      speed = Speed * frame_time

      dy -= speed if keys.pressed?(Keys::W)
      dx -= speed if keys.pressed?(Keys::A)
      dy += speed if keys.pressed?(Keys::S)
      dx += speed if keys.pressed?(Keys::D)

      if dx != 0 && dy != 0
        # 45 deg, from sqrt(x^2 + y^2) at 45 deg
        const = 0.70710678118_f64
        dx *= const
        dy *= const
      end

      if dx != 0 || dy != 0
        move(dx, dy)
      end
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
