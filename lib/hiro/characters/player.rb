module Hiro
  module Characters
    class Player
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
      end

      # player.equip_gear(gear)
      # check if item.equippable?
      # if not errors.add_errors to item and return item
      # equipped_gear.update with item
      # return Result object

      def equip(params)
        equipped_gear[:weapon] = params[:weapon]
        equipped_gear
      end
    end
  end
end
