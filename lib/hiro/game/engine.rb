module Hiro
  module Game
    class Engine
      attr_reader :window, :player

      def initialize(**options)
        @window = Game::Window.new(map: options.dig(:map))
        @player = Characters::Player.new(options.dig(:player))
      end
    end
  end
end
