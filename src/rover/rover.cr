module Rover
  class Rover
    getter x : Float64
    getter y : Float64
    getter animations
    getter speed
    getter dx
    getter dy

    InitialSpeed = 33
    Acceleration = 100
    Decceleration = 75
    MaxSpeed = 1133
    Sheet = "./assets/rover.png"
    SpriteFPS = 60
    SpriteSize = 192

    def initialize(x = 0, y = 0)
      @x = x
      @y = y
      @dx = 0_f64
      @dy = 0_f64
      @speed = 0_f32

      # animations
      up = GSF::Animation.new((SpriteFPS / 3).to_i, loops: false)
      up.add(Sheet, 0, 0, SpriteSize, SpriteSize)

      right_up = GSF::Animation.new((SpriteFPS / 3).to_i, loops: false)
      right_up.add(Sheet, 1 * SpriteSize, 0, SpriteSize, SpriteSize)

      right = GSF::Animation.new((SpriteFPS / 3).to_i, loops: false)
      right.add(Sheet, 2 * SpriteSize, 0, SpriteSize, SpriteSize)

      right_down = GSF::Animation.new((SpriteFPS / 3).to_i, loops: false)
      right_down.add(Sheet, 3 * SpriteSize, 0, SpriteSize, SpriteSize)

      down = GSF::Animation.new((SpriteFPS / 3).to_i, loops: false)
      down.add(Sheet, 4 * SpriteSize, 0, SpriteSize, SpriteSize)

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
      ndx = 0_f64
      ndy = 0_f64

      ndy -= 1 if keys.pressed?(Keys::W)
      ndx -= 1 if keys.pressed?(Keys::A)
      ndy += 1 if keys.pressed?(Keys::S)
      ndx += 1 if keys.pressed?(Keys::D)

      # accelerate
      if ndx != 0 || ndy != 0
        @speed = InitialSpeed * frame_time if speed <= InitialSpeed * frame_time
        @speed += Acceleration * frame_time
        @speed = MaxSpeed * frame_time if @speed > MaxSpeed * frame_time
      end

      # decelerate
      if speed > 0
        @speed -= Decceleration * frame_time
        @speed = 0 if speed < 0
      end

      # angle directions
      if ndx != 0 && ndy != 0
        # 45 deg, from sqrt(x^2 + y^2) at 45 deg
        const = 0.70710678118_f64
        ndx *= const
        ndy *= const
      end

      # new dx, dy and animate movement
      if ndx != 0 || ndy != 0
        @dx = ndx
        @dy = ndy

        animate_move(dx, dy)
      end

      move(dx * speed, dy * speed)
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
        if dy < 0
          @animations.play(:left_up)
        elsif dy > 0
          @animations.play(:left_down)
        else
          @animations.play(:left)
        end
      elsif dy < 0
        @animations.play(:up)
      elsif dy > 0
        @animations.play(:down)
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
