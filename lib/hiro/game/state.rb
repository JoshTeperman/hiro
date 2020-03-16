module Hiro
  module Game
    class State
      include Game::Errors

      attr_reader :current_map, :enemies
      attr_accessor :is_in_combat

      def initialize(current_map:, enemies:)
        @current_map = current_map
        @enemies = map_enemies(enemies)
        @is_in_combat = false
        super(self)
      end

      def map_enemies(enemies)
        enemies.map do |enemy|
          return enemy if enemy.is_a?(Characters::Enemy)

          Characters::Enemy.new(enemy)
        end
      end
    end
  end
end
