module Rover
  class Rover
    getter x : Float64
    getter y : Float64
    getter animations

    Speed = 333
    Sheet = "./assets/rover.png"

    def initialize(x = 0, y = 0)
      # sprite size
      size = 192
      @x = x
      @y = y

      fps = 60

      up = GSF::Animation.new((fps / 3).to_i, loops: false)
      up.add(Sheet, 0, 0, size, size)

      right_up = GSF::Animation.new((fps / 3).to_i, loops: false)
      right_up.add(Sheet, 1 * size, 0, size, size)

      right = GSF::Animation.new((fps / 3).to_i, loops: false)
      right.add(Sheet, 2 * size, 0, size, size)

      right_down = GSF::Animation.new((fps / 3).to_i, loops: false)
      right_down.add(Sheet, 3 * size, 0, size, size)

      down = GSF::Animation.new((fps / 3).to_i, loops: false)
      down.add(Sheet, 4 * size, 0, size, size)

      @animations = GSF::Animations.new(:up, up)
      @animations.add(:right_up, right_up)
      @animations.add(:left_up, right_up, flip_horizontal: true)
      @animations.add(:right, right)
      @animations.add(:left, right, flip_horizontal: true)
      @animations.add(:right_down, right_down)
      @animations.add(:left_down, right_down, flip_horizontal: true)
      @animations.add(:down, down)
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
        animate_move(dx, dy)
        move(dx, dy)
      end
    end

    def animate_move(dx : Float64, dy : Float64)
      if dx > 0
        if dy < 0
          @animations.play(:right_up)
        elsif dy > 0
          @animations.play(:right_down)
        else
          @animations.play(:right)
        end
      elsif dx < 0
        if dy > 0
          @animations.play(:left_up)
        elsif dy < 0
          @animations.play(:left_down)
        else
          @animations.play(:left)
        end
      elsif dy > 0
        @animations.play(:down)
      elsif dy < 0
        @animations.play(:up)
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
