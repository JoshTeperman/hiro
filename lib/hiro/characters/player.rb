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
        @character_level = player_hash.fetch(:character_level)
        @location = player_hash.fetch(:location)
        @gear = {}
      end

      def equip(params)
        # What messages need to be sent?
        # What are the roles?

        # Method should:
        # 1) Accept hash with only the items you want to equip / unequip
        # 2) Check the character_level requirements for each item
        # 3) Create copy of gear object, updating only the corresponding gear slots for items that meet the character_level requirement
        # 4) Return a failure for each failed item with error messages
        # 5) Return updated gear object
        # 6) Save copy of previous gear object to allow #undo

        # OTHER
        # - toggle 'equipped' boolean on item
        # - add / remove items from inventory
        # - recalculate character stats
        # - check equip can be called (eg: not during battle etc)

        # merge (will just replace all key/values)
        # delete (if returns true then there was a value there)
      end
    end
  end
end
