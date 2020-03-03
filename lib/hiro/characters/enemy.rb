module Hiro
  module Characters
    class Enemy
      include Game::Errors

      attr_reader :x, :y

      def initialize(x: 0, y: 0)
        @x = x
        @y = y
        super(self)
      end
    end
  end
end
