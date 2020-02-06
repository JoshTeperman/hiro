require 'dry-monads'

module Hiro
  module Game
    class Map
      include Game::Errors
      include Dry::Monads[:result]

      attr_reader :shape, :entry_coordinates, :exit_coordinates

      def initialize(map_name:)
        super(self)
        @data = load_map_data(map_name)
        @shape = data.dig('shape')
        @entry_coordinates = data.dig('entry_coordinates').symbolize_keys
        @exit_coordinates = data.dig('exit_coordinates').symbolize_keys
      end

      private

      attr_reader :data

      def load_map_data(map_name)
        YAML.load_file('lib/hiro/game/data/maps.yml').fetch(map_name.to_s) { add_error('Map not found', :data) }
      end
    end
  end
end
