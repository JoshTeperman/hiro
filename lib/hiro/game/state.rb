module Hiro
  module Game
    class State
      include Game::Errors

      attr_reader :current_map, :enemies
      attr_accessor :is_in_combat, :last_player_coordinates

      def initialize(current_map:, enemy_data:, last_player_coordinates:)
        @current_map = current_map
        @enemies = map_enemies(enemy_data)
        @is_in_combat = false
        @last_player_coordinates = last_player_coordinates

        super(self)
      end

      def kills
        enemies.select(&:dead?)
      end

      def clear_killed_enemies
        enemies.reject!(&:dead?)
      end

      private

      def map_enemies(enemy_data)
        enemy_data.map { |enemy| Characters::Enemy.new(enemy) }
      end
    end
  end
end
