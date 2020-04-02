module Hiro
  module Items
    class Weapon
      include Game::Errors

      attr_reader :weapon_class, :name, :min_character_level, :min_damage, :max_damage, :range

      def initialize(weapon_class_attributes:, name:, min_character_level:, range:)
        @weapon_class = Struct::WeaponClass.new(weapon_class_attributes)
        @name = name
        @min_character_level = min_character_level
        @min_damage = roll_min_damage
        @max_damage = roll_max_damage
        @range = range

        super(self)
      end

      def name_or_type
        name || type
      end

      def type
        weapon_class.type
      end

      def roll_min_damage
        rand(@weapon_class.min_minimum_damage..@weapon_class.max_minimum_damage)
      end

      def roll_max_damage
        rand(@weapon_class.min_maximum_damage..@weapon_class.max_maximum_damage)
      end

      def roll_attack_damage
        rand(min_damage..max_damage)
      end

      Struct.new(
        'WeaponClass',
        :type,
        :min_minimum_damage,
        :max_minimum_damage,
        :min_maximum_damage,
        :max_maximum_damage,
        keyword_init: true
      )
    end
  end
end
