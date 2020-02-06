module Hiro
  module Game
    class Engine
      attr_reader :window, :player

      def initialize(options)
        @window = Game::Window.new(map: [])
        @player = Characters::Player.new(options[:saved_player])
      end
    end
  end
end

