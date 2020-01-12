module Hiro
  module Items
    class Weapon
      attr_reader :weapon_class, :name, :min_character_level, :base_damage, :range

      def initialize(
          weapon_class:,
          name:,
          min_character_level:,
          base_damage:,
          range:
        )

        @weapon_class = weapon_class
        @name = name
        @min_character_level = min_character_level
        @base_damage = base_damage
        @range = range
      end
    end
  end
end
