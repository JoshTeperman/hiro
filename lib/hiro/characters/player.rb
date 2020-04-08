# frozen_string_literal: true

require 'dry-monads'

module Hiro
  module Characters
    class Player
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :name, :character_level, :life, :mana, :hit_chance, :max_life, :max_mana, :strength, :dexterity, :vitality, :defense
      attr_accessor :equipped_items, :x, :y

      def initialize(name:, character_level:, life: nil, mana:, max_life:, max_mana:, strength:, dexterity:, vitality:, x:, y:, equipped_items:)
        @name = name
        @character_level = character_level
        @mana = mana
        @max_life = max_life
        @max_mana = max_mana
        @life = life || @max_life
        @strength = strength
        @dexterity = dexterity
        @vitality = vitality
        @x = x
        @y = y
        @equipped_items = map_equipped_items(equipped_items)
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
