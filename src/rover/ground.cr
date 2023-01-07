require "./tile_map"

module Rover
  class Ground
    getter tile_map : TileMap

    SpriteSize = 256
    TextureFile = "./assets/ground.png"

    def initialize(cols = 10, rows = 10)
      x = cols // 2 * SpriteSize
      y = rows // 2 * SpriteSize
      @tile_map = TileMap.new(TextureFile, SF.vector2(SpriteSize, SpriteSize), cols, rows)
      @tile_map.position = {-x, -y}
    end

    def update(frame_time, keys : Keys)

    end

    def draw(window : SF::RenderWindow)
      window.draw(tile_map)
    end
  end
end
