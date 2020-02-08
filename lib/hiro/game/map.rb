require 'dry-monads'

module Hiro
  module Game
    class Map
      include Game::Errors
      include Dry::Monads[:result]

      attr_reader :shape, :entry_coordinates, :exit_coordinates

      def initialize(map_name:)
        super(self)
        @data = fetch_map_data(map_name)
        @shape = data.fetch(:shape) { [] }
        @entry_coordinates = data.fetch(:entry_coordinates)
        @exit_coordinates = data.fetch(:exit_coordinates)
      end

      private

      attr_reader :data

      def fetch_map_data(map_name)
        map_data = load_from_yaml(map_name)

        return {} unless valid?

        map_data
      end

      def load_from_yaml(map_name)
        path = File.join('lib/hiro/game/data/', map_name)

        YAML.load_file("#{path}.yml").fetch(map_name.to_s).symbolize_keys if File.exist?("#{path}.yml")

        raise FileNotFoundError "Error loading map data: File '#{file_name}' not found at path #{path}"
      rescue => e
        p e.message
        add_error('Error loading map data', :data)
      end
    end
  end
end
