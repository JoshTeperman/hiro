module Hiro
  module Items
    class Chest < Armour
      attr_reader :armour_class, :name, :min_character_level

      def initialize(armour_class_attributes:, name:, min_character_level:)
        super
      end
    end
  end
end
