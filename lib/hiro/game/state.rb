module Hiro
  module Game
    class State
      include Game::Errors

      attr_reader :window
      def initialize(window:)
        @window = window
        super(self)
      end
    end
  end
end
