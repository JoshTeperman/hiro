module Hiro
  module Game
    class Engine
      attr_reader :window, :player

      def initialize(**options)
        require 'pry';binding.pry
        @window = Game::Window.new(map: options.dig(:game_state, :map))
        @player = Characters::Player.new(options.dig(:player))
      end
    end
  end
end
