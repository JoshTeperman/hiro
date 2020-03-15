module Hiro
  module Characters
    class Enemy
      include Game::Errors

      attr_reader :life, :level, :strength, :dexterity, :defense
      attr_accessor :x, :y

      def initialize(x:, y:, life:, level:, strength:, dexterity:, defense:)
        @x = x
        @y = y
        super(self)
      end
    end
  end
end
