module Hiro
  module Items
    class Sword < Weapon
      attr_reader :weapon_class, :name, :min_character_level, :range

      def initialize(weapon_class:, name:, min_character_level:, range: 1)
      super(
          weapon_class: weapon_class,
          name: name,
          min_character_level: min_character_level,
          range: range
        )
      end
    end
  end
end
