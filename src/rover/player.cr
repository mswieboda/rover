require "./movable"

module Rover
  class Player < Movable
    InitialSpeed = 3
    Acceleration = 80
    Decceleration = 75
    MaxSpeed = 333
    SpriteSheet = "./assets/player.png"
    SpriteWidth = 64
    SpriteHeight = 96

    def initialize(x = 0, y = 0)
      super

      @enabled = true
    end

    def self.initial_speed
      InitialSpeed
    end

    def self.acceleration
      Acceleration
    end

    def self.decceleration
      Decceleration
    end

    def self.max_speed
      MaxSpeed
    end

    def self.sprite_sheet
      SpriteSheet
    end

    def self.sprite_width
      SpriteWidth
    end

    def self.sprite_height
      SpriteHeight
    end
  end
end
