module Hiro
  module Game
    class Map
      include Game::Errors

      attr_reader :shape, :entry_coordinates, :exit_coordinates

      def initialize(shape:, entry_coordinates:, exit_coordinates:)
        @shape = shape
        @entry_coordinates = entry_coordinates
        @exit_coordinates = exit_coordinates
        super(self)
      end
    end
  end
end
