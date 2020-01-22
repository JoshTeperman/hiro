module Hiro
  module Items
    class Armour
      attr_reader :name, :min_character_level
      def initialize(armour_class_attributes:, name:, min_character_level:)
        @name = name
        @min_character_level = min_character_level

      end
    end
  end
end
