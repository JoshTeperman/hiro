module Hiro
  module Items
    class Weapon
      include Game::Errors

      attr_reader :weapon_class, :name, :min_character_level, :min_damage, :max_damage, :range

      def initialize(weapon_class_attributes:, name:, min_character_level:, range:)
        @weapon_class = Struct::WeaponClass.new(weapon_class_attributes)
        @name = name
        @min_character_level = min_character_level
        @min_damage = weapon_class.roll_min_damage
        @max_damage = weapon_class.roll_max_damage
        @range = range

        super(self)
      end

      Struct.new(
        'WeaponClass',
        :type,
        :min_minimum_damage,
        :max_minimum_damage,
        :min_maximum_damage,
        :max_maximum_damage,
        keyword_init: true
      ) do
        def roll_min_damage
          rand(min_minimum_damage..max_minimum_damage)
        end

        def roll_max_damage
          rand(min_maximum_damage..max_maximum_damage)
        end
      end
    end
  end
end
