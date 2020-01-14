module Hiro
  module Items
    class Weapon
      attr_reader :weapon_class, :name, :min_character_level, :base_damage, :range

      def initialize(
        weapon_class_attributes:,
        name:,
        min_character_level:,
        range:
      )
        @weapon_class = Struct::WeaponClass.new(weapon_class_attributes)
        @name = name
        @min_character_level = min_character_level
        @base_damage = weapon_class.roll_base_damage
        @range = range
      end

      private

      Struct.new('WeaponClass', :min_damage, :max_damage, :max_base_damage, :type, keyword_init: true) do
        def roll_base_damage
          rand(min_damage..max_base_damage)
        end
      end

    end
  end
end
