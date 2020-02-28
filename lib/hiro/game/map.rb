require 'dry-monads'
require 'yaml'

module Hiro
  module Game
    class Map
      include Game::Errors
      include Dry::Monads[:result]

      attr_reader :shape, :entry_coordinates, :exit_coordinates

      def initialize(map_name:)
        super(self)
        data = fetch_map_data(map_name).deep_symbolize_keys
        @shape = data.dig(:shape)
        @entry_coordinates = data.dig(:entry_coordinates)
        @exit_coordinates = data.dig(:exit_coordinates)
      end

      private

      attr_reader :data

      def fetch_map_data(map_name)
        map_data = load_from_yaml(map_name)

        return {} unless valid?

        map_data
      end

      def load_from_yaml(map_name)
        path = File.join(Hiro::Constants::MAPS_PATH, map_name)

        unless File.exist?("#{path}.yml")
          raise FileNotFoundError.new "Error loading map data: File '#{map_name}.yml' not found at path #{path}"
        end

        YAML.load_file("#{path}.yml")
      rescue KeyError => e
        add_error("Error loading map data: Map '#{map_name}' not found", :data)
      rescue FileNotFoundError => e
        add_error(e.message, :data)
      end
    end
  end
end
