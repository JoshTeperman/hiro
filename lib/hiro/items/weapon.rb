module Hiro
  module Items
    class Weapon
      attr_reader :name, :min_level, :base_damage

      def initialize(name:, min_level:, base_damage:)
        @name = name
        @min_level = min_level
        @base_damage = base_damage
        @range = range
      end
    end
  end
end
