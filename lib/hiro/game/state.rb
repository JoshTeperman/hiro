module Hiro
  module Game
    class State
      include Game::Errors

      attr_reader :window
      attr_accessor :is_in_combat

      def initialize(window:)
        @window = window
        @is_in_combat = false
        super(self)
      end
    end
  end
end
