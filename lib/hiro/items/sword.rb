module Hiro
  module Items
    class Sword < Weapon
      attr_reader :name, :min_level, :base_damage, :range, :type, :min_damage, :max_damage, :max_base_damage

      def initialize(type:, name:, min_level:, base_damage:, range: 1, min_damage:, max_damage:)
        super(
          name: name,
          min_level: min_level,
          base_damage: base_damage,
          range: range
        )
        @type = OpenStruct.new()

      end
    end
  end
end
