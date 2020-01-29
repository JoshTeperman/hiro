require 'hiro/game/errors_spec'

module Hiro
  module Game
    class Window
      include Game::Errors
      def initialize
        super(self)
      end
    end
  end
end
