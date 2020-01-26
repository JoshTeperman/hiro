module Hiro
  module Items
    class Armour
      include Game::Errors

      attr_reader :armour_class, :name, :min_character_level, :base_defense

      def initialize(armour_class_attributes:, name:, min_character_level:)
        @armour_class = Struct::ArmourClass.new(armour_class_attributes)
        @name = name
        @min_character_level = min_character_level
        @base_defense = armour_class.roll_base_defense

        super(self)
      end

      Struct.new('ArmourClass', :type, :min_defense, :max_defense, keyword_init: true) do
        def roll_base_defense
          rand(min_defense..max_defense)
        end
      end
    end
  end
end
