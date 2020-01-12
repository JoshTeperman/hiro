module Hiro
  module Items
    class Weapon
      attr_reader :weapon_class, :name, :min_character_level, :base_damage, :range

      def initialize(
        weapon_class:,
        name:,
        min_character_level:,
        range:
      )

        @weapon_class = weapon_class
        @name = name
        @min_character_level = min_character_level
        @base_damage = roll_base_damage
        @range = range
      end

      def roll_base_damage
        rand(weapon_class.min_damage..weapon_class.max_base_damage)
      end
    end
  end
end
