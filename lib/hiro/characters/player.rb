require 'dry-monads'

module Hiro
  module Characters
    class Player
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :attributes, :name, :life, :mana, :character_level, :location
      attr_accessor :equipped_gear, :switch_gear

      def initialize(player_hash)
        @name = player_hash.fetch(:name)
        @attributes = player_hash.fetch(:attributes)
        @life = player_hash.fetch(:life)
        @mana = player_hash.fetch(:mana)
        @character_level = player_hash.fetch(:character_level)
        @location = player_hash.fetch(:location)
        @equipped_gear = {}
        @switch_gear = {}

        super(self)
      end

      def equip(item)
        if item.values.last.min_character_level > character_level
          item[:errors] = ["#{item.keys.last.capitalize}: You do not meet the level requirements for this item"]
          return Dry::Monads::Failure(item)
        elsif item[:weapon] == equipped_gear[:weapon]
          item[:errors] = ["#{item.keys.last.capitalize}: Item is already equipped"]
          return Dry::Monads::Failure(item)
        end

        equipped_gear[item.keys.last] = item.values.last

        Dry::Monads::Success(equipped_gear)
      end
    end
  end
end
