module Rpg
  module Characters
    class Player
      attr_reader :name, :life

      def initialize(player_hash)
        @name = player_hash[:name]
        @life = player_hash[:life]
      end
    end
  end
end
