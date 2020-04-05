# frozen_string_literal: true

require 'dry-monads'

module Hiro
  module Characters
    class Player
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :attributes, :name, :life, :mana, :character_level
      attr_accessor :equipped_gear, :x, :y

      def initialize(player_params)
        @name = player_params.fetch(:name)
        @life = player_params.fetch(:life)
        @mana = player_params.fetch(:mana)
        @character_level = player_params.fetch(:character_level)
        @x = player_params.fetch(:x)
        @y = player_params.fetch(:y)
        @attributes = player_params.fetch(:attributes)
        @equipped_gear = map_equipped_gear(player_params.fetch(:equipped_gear))
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
        equipped_gear.fetch(:weapon, 'bare hands')
      end

      private

      def map_equipped_gear(weapon: nil)
        weapon = Items::Weapon.new(weapon) if weapon
        { weapon: weapon }
      end
    end
  end
end
