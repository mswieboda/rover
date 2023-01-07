module Rover
  class TileMap < SF::Transformable
    include SF::Drawable

    def initialize(tileset, tile_size, width, height, tiles = [] of UInt8)
      super()

      @tileset = SF::Texture.from_file(tileset)
      @vertices = SF::VertexArray.new(SF::Quads)

      tiles_per_row = @tileset.size.x // @tileset.size.x

      (0...height).each do |y|
        (0...width).each do |x|
          tile_index = tiles.empty? ? 0 : tiles[width * y + x]

          tile_pos = SF.vector2(
            tile_index % tiles_per_row,
            tile_index // tiles_per_row
          )

          destination = SF.vector2(x, y)

          [{0, 0}, {1, 0}, {1, 1}, {0, 1}].each do |delta|
            vertex = SF::Vertex.new(
              (destination + delta) * tile_size,
              tex_coords: (tile_pos + delta) * tile_size
            )

            @vertices.append(vertex)
          end
        end
      end
    end

    def draw(target, states)
      states.transform *= transform
      states.texture = @tileset
      target.draw(@vertices, states)
    end
  end
end
