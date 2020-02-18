module Hiro
  module Game
    class State
      include Game::Errors

      def initialize
        super(self)
      end
    end
  end
end
