module Hiro
  module Items
    class Weapon
      include Game::Errors

      attr_reader :weapon_class, :name, :min_character_level, :base_damage, :range, :errors

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

        super
      end

      Struct.new('WeaponClass', :type, :min_damage, :max_damage, :max_base_damage, keyword_init: true) do
        def roll_base_damage
          rand(min_damage..max_base_damage)
        end
      end

    end
  end
end
