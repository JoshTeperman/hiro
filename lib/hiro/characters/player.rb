module Hiro
  module Characters
    class Player
      attr_reader :name, :attributes
      attr_accessor :equipped_weapon

      def initialize(player_hash)
        @name = player_hash[:name]
        @attributes = player_hash[:attributes]
        @equipped_weapon = nil
      end
    end
  end
end
