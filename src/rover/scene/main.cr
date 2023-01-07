require "../rover"
require "../player"
require "../hud"

module Rover::Scene
  class Main < GSF::Scene
    getter view : GSF::View
    getter hud
    # getter player
    getter rover

    def initialize(window)
      super(:main)

      @view = GSF::View.from_default(window).dup

      view.zoom(1 / Screen.scaling_factor)

      # @player = Player.new(x: 300, y: 300)
      @rover = Rover.new(x: 300, y: 300)
      @hud = HUD.new
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      # player.update(frame_time, keys)
      rover.update(frame_time, keys)
      hud.update(frame_time)
    end

    def draw(window)
      # player.draw(window)
      rover.draw(window)
      hud.draw(window)
    end
  end
end
