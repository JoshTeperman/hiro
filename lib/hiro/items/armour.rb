module Hiro
  module Items
    class Armour
      include Game::Errors

      attr_reader :armour_class, :name, :min_character_level, :defense

      def initialize(armour_class_attributes:, name:, min_character_level:)
        @armour_class = Struct::ArmourClass.new(armour_class_attributes)
        @name = name
        @min_character_level = min_character_level
        @defense = armour_class.calculate_defense

        super(self)
      end

      Struct.new('ArmourClass', :type, :min_defense, :max_defense, keyword_init: true) do
        def calculate_defense
          roll_base_defense
        end

        def roll_base_defense
          rand(min_defense..max_defense)
        end
      end
    end
  end
end
