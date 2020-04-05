# frozen_string_literal: true

require 'dry-monads'

module Hiro
  module Characters
    class Player
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :name,
                  :character_level,
                  :life,
                  :mana,
                  :hit_chance,
                  :max_life,
                  :max_mana,
                  :strength,
                  :dexterity,
                  :vitality,
                  :defense
      attr_accessor :equipped_items, :x, :y

      def initialize(player_params)
        @name = player_params.fetch(:name)
        @character_level = player_params.fetch(:character_level)
        @life = player_params.fetch(:life)
        @mana = player_params.fetch(:mana)
        @max_life = player_params.fetch(:max_life)
        @max_mana = player_params.fetch(:max_mana)
        @strength = player_params.fetch(:strength)
        @dexterity = player_params.fetch(:dexterity)
        @vitality = player_params.fetch(:vitality)
        @x = player_params.fetch(:x)
        @y = player_params.fetch(:y)
        @equipped_items = map_equipped_items(player_params.fetch(:equipped_items))
        @hit_chance = calculate_hit_chance
        @defense = calculate_defense

        super(self)
      end

      def equip(item)
        if item.values.last.min_character_level > character_level
          item[:errors] = ["#{item.keys.last.capitalize}: You do not meet the level requirements for this item"]
          return Dry::Monads::Failure(item)
        elsif item[:weapon] == equipped_items[:weapon]
          item[:errors] = ["#{item.keys.last.capitalize}: Item is already equipped"]
          return Dry::Monads::Failure(item)
        end

        equipped_items[item.keys.last] = item.values.last

        Dry::Monads::Success(equipped_items)
      end

      def alive?
        life.positive?
      end

      def dead?
        !alive?
      end

      def lose_life(amount)
        @life -= amount
      end

      # TODO: This should be extracted to a movement module when introducing movement for Enemy / Npc
      def up
        { y: @y - 1 }
      end

      def down
        { y: @y + 1 }
      end

      def right
        { x: @x + 1 }
      end

      def left
        { x: @x - 1 }
      end

      def move(x:, y:)
        @x = x
        @y = y
      end

      def weapon
        equipped_items.fetch(:weapon, 'bare hands')
      end

      def chest
        equipped_items.dig(:chest)
      end

      private

      def map_equipped_items(weapon: nil)
        weapon = Items::Weapon.new(weapon) if weapon
        { weapon: weapon }
      end

      def calculate_hit_chance
        100 + dexterity
      end

      def calculate_defense
        total_item_defense = equipped_items.reduce(0) do |total, item|
          total += item.defense if item.respond_to?(:defense)
          total
        end

        strength + total_item_defense
      end
    end
  end
end
