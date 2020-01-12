module Hiro
  module Items
    class Sword < Weapon
      attr_reader :name, :min_level, :base_damage, :range

      def initialize(name:, min_level:, base_damage:, range: 1)
        super
      end
    end
  end
end
