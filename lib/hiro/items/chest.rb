module Hiro
  module Items
    class Chest < Armour
      attr_reader :armour_class, :name, :min_character_level

      def initialize(armour_class_attributes:, name: nil, min_character_level:, defense: nil)
        super
      end
    end
  end
end
