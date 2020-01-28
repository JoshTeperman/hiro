require 'dry-monads'

module Hiro
  module Game
    class Engine
      include Dry::Monads[:result]
      def initialize
        @window = Game::Window.new
        @player = Characters::Player.new
      end
    end
  end
end
