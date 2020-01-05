module Hiro
  module Items
    class Weapon
      attr_reader :type, :equipped
      def initialize(weapon_hash)
        @type = weapon_hash[:type]
        @equipped = weapon_hash[:equipped]
      end
    end
  end
end
