require "../ground"
require "../player"
require "../rover"
require "../ore"
require "../hud"

module Rover::Scene
  class Main < GSF::Scene
    getter view : GSF::View
    getter ground : Ground
    getter player : Player
    getter rover : Rover
    getter ore
    getter hud

    def initialize(window)
      super(:main)

      @view = GSF::View.from_default(window).dup

      view.zoom(1 / Screen.scaling_factor)

      @ground = Ground.new
      @rover = Rover.new
      @player = Player.new
      @ore = Ore.new(x: 500, y: -300)
      @hud = HUD.new
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      ground.update(frame_time, keys)
      player.update(frame_time, keys)
      rover.update(frame_time, keys)

      if rover.enabled?
        view.center(rover.x, rover.y)
      else
        view.center(player.x, player.y)
      end

      ore.update(frame_time)
      hud.update(frame_time)
    end

    def draw(window)
      # map view
      view.set_current

      ground.draw(window)
      ore.draw(window)
      rover.draw(window)
      player.draw(window)

      # default view
      view.set_default_current

      hud.draw(window)
    end
  end
end
