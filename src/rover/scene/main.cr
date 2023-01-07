require "../map"
require "../hud"

module Rover::Scene
  class Main < GSF::Scene
    getter view : GSF::View
    getter map : Map
    getter hud

    def initialize(window)
      super(:main)

      @view = GSF::View.from_default(window).dup

      view.zoom(1 / Screen.scaling_factor)

      @map = Map.new(x: 0, y: 0)
      @hud = HUD.new
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      map.update(frame_time, keys)
      hud.update(frame_time)
    end

    def draw(window)
      map.draw(window)
      hud.draw(window)
    end
  end
end
