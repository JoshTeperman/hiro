module Hiro
  module Characters
    class Player
      attr_reader :attributes, :name, :life, :mana, :character_level, :location
      attr_accessor :gear

      def initialize(player_hash)
        @name = player_hash.fetch(:name)
        @attributes = player_hash.fetch(:attributes)
        @life = player_hash.fetch(:life)
        @mana = player_hash.fetch(:mana)
        @level = player_hash.fetch(:level)
        @location = player_hash.fetch(:location)
        @gear = {}
      end
    end
  end
end
