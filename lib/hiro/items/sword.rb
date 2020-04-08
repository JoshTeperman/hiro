module Hiro
  module Items
    class Sword < Weapon
      attr_reader :weapon_class, :name
      attr_accessor :min_character_level

      def initialize(weapon_class_attributes:, name:, min_character_level:)
        super
      end
    end
  end
end
