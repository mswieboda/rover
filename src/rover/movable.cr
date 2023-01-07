module Rover
  class Movable
    getter x : Float64
    getter y : Float64
    getter animations
    getter speed
    getter dx
    getter dy
    getter? enabled
    getter? hidden

    InitialSpeed = 3
    Acceleration = 80
    Decceleration = 75
    MaxSpeed = 333
    Sheet = "./assets/player.png"
    SpriteFPS = 60
    SpriteWidth = 64
    SpriteHeight = 96

    def initialize(x = 0, y = 0)
      @x = x
      @y = y
      @dx = 0_f64
      @dy = 0_f64
      @speed = 0_f32
      @enabled = false
      @hidden = false

      # animations
      up = GSF::Animation.new((sprite_fps / 3).to_i, loops: false)
      up.add(sprite_sheet, 0, 0, sprite_width, sprite_height)

      right_up = GSF::Animation.new((sprite_fps / 3).to_i, loops: false)
      right_up.add(sprite_sheet, 1 * sprite_width, 0, sprite_width, sprite_height)

      right = GSF::Animation.new((sprite_fps / 3).to_i, loops: false)
      right.add(sprite_sheet, 2 * sprite_width, 0, sprite_width, sprite_height)

      right_down = GSF::Animation.new((sprite_fps / 3).to_i, loops: false)
      right_down.add(sprite_sheet, 3 * sprite_width, 0, sprite_width, sprite_height)

      down = GSF::Animation.new((sprite_fps / 3).to_i, loops: false)
      down.add(sprite_sheet, 4 * sprite_width, 0, sprite_width, sprite_height)

      @animations = GSF::Animations.new(:up, up)
      @animations.add(:right_up, right_up)
      @animations.add(:left_up, right_up, flip_horizontal: true)
      @animations.add(:right, right)
      @animations.add(:left, right, flip_horizontal: true)
      @animations.add(:right_down, right_down)
      @animations.add(:left_down, right_down, flip_horizontal: true)
      @animations.add(:down, down)
    end

    def initial_speed
      self.class.initial_speed
    end

    def self.initial_speed
      InitialSpeed
    end

    def acceleration
      self.class.acceleration
    end

    def self.acceleration
      Acceleration
    end

    def decceleration
      self.class.decceleration
    end

    def self.decceleration
      Decceleration
    end

    def max_speed
      self.class.max_speed
    end

    def self.max_speed
      MaxSpeed
    end

    def sprite_sheet
      self.class.sprite_sheet
    end

    def self.sprite_sheet
      SpriteSheet
    end

    def sprite_fps
      self.class.sprite_fps
    end

    def self.sprite_fps
      SpriteFPS
    end

    def sprite_width
      self.class.sprite_width
    end

    def self.sprite_width
      SpriteWidth
    end

    def sprite_height
      self.class.sprite_height
    end

    def self.sprite_height
      SpriteHeight
    end

    def enable
      @enabled = true
    end

    def disable
      @enabled = false
    end

    def hide
      @hidden = true
      @enabled = false
    end

    def show(enable = true)
      @hidden = false
      @enabled = enable
    end

    def update(frame_time, keys : Keys)
      animations.update(frame_time)

      update_movement(frame_time, keys) if enabled?
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
        @speed = initial_speed * frame_time if speed <= initial_speed * frame_time
        @speed += acceleration * frame_time
        @speed = max_speed * frame_time if @speed > max_speed * frame_time
      end

      # decelerate
      if speed > 0
        @speed -= decceleration * frame_time
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
      animations.draw(window, x, y) unless hidden?
    end
  end
end
