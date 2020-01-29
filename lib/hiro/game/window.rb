require 'hiro/game/errors_spec'

module Hiro
  module Game
    class Window
      include Game::Errors

      attr_reader :map, :entities
      def initialize
        @map = map
        @entities = []
        super(self)
      end
    end
  end
end
