module Hiro
  module Characters
    class Player
      attr_reader :attributes, :name, :life, :mana, :level, :location
      attr_accessor :equipped_weapon

      def initialize(player_hash)
        @name = player_hash[:name]
        @attributes = player_hash[:attributes]
        @equipped_weapon = nil
        @life = player_hash[:life]
        @mana = player_hash[:mana]
        @level = player_hash[:level]
        @location = player_hash[:location]
      end
    end
  end
end
