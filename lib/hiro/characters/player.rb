module Hiro
  module Characters
    class Player
      attr_reader :attributes, :name, :life, :mana, :character_level, :location
      attr_accessor :equipped_gear

      def initialize(player_hash)
        @name = player_hash.fetch(:name)
        @attributes = player_hash.fetch(:attributes)
        @life = player_hash.fetch(:life)
        @mana = player_hash.fetch(:mana)
        @character_level = player_hash.fetch(:character_level)
        @location = player_hash.fetch(:location)
        @equipped_gear = {}
        @switch_gear = {}
      end

      def equip(params)
        # player.equip_gear(gear)
        # return if game.can_equip? is false
        # for gear.map item.equippable?
        # if item.equippable? gear.equip_item
        # else errors.add_errors to item
        # player.update_equipped_gear(gear)
        # player.update_gear (replace player.switch_gear if player.gear != gear)
      end
    end
  end
end
