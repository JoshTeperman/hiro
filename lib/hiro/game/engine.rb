module Hiro
  module Game
    class Engine
      def initialize
        @window = Game::Window.new
        @player = Characters::Player.new
      end
    end
  end
end
