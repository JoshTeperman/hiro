module Hiro
  module Items
    class Sword < Weapon
      attr_reader :name, :min_level, :base_damage, :range

      def initialize(name:, min_level:, base_damage:, range: 1)
        super(name: name, min_level: min_level, base_damage: base_damage, range: range)
      end
    end
  end
end
