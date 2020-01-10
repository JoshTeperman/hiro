module Hiro
  module Items
    class Weapon
      attr_reader :weapon_class, :name, :min_level, :base_damage
      def initialize(weapon_class:, name:, min_level:, base_damage:)
        @weapon_class = weapon_class
        @name = name
        @min_level = min_level
        @base_damage = base_damage
      end
    end
  end
end
