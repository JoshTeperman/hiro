module Hiro
  module Game
    class State
      include Game::Errors

      attr_reader :current_map, :enemies
      attr_accessor :is_in_combat

      def initialize(current_map:, enemy_data:)
        @current_map = current_map
        @enemies = map_enemies(enemy_data)
        @is_in_combat = false

        super(self)
      end

      def map_enemies(enemy_data)
        enemy_data.map { |enemy| Characters::Enemy.new(enemy) }
      end
    end
  end
end
