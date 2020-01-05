module Hiro
  module Characters
    class Player
      attr_reader :name, :attributes

      def initialize(player_hash)
        @name = player_hash[:name]
        @attributes = player_hash[:attributes]
      end
    end
  end
end
