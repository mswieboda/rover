require "./movable"

module Rover
  class Rover < Movable
    InitialSpeed = 33
    Acceleration = 100
    Decceleration = 75
    MaxSpeed = 1133
    SpriteSheet = "./assets/rover.png"
    SpriteWidth = 192
    SpriteHeight = 192

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
