# frozen_string_literal: true

require 'dry-monads'
require 'tty-box'

module Hiro
  module Game
    class Window
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :map, :entities

      def initialize(map_name:, entities: [])
        @map = Game::Map.new(map_name: map_name)
        @entities = entities
        super(self)
      end

      def add_entities(new_entities)
        new_entities.each do |entity|
          validate_entity(entity)
          return Dry::Monads::Failure(entity) unless entity.valid?

          entities << entity
        end

        Dry::Monads::Success(entities)
      end

      def draw
        map_string = prepare_map_string
        print TTY::Box.frame map_string

        map_string
      end

      def prepare_map_string
        map_copy = map.shape.deep_dup
        entities.map do |e|
          # TODO: if entity already as same coordinates, draw the one with higher z-index
          case e.class.to_s
          when Characters::Player.to_s
            map_copy[e.y][e.x] = '*'
          when Characters::Enemy.to_s
            map_copy[e.y][e.x] = 'O'
          end
        end

        map_copy.map { |row| row.join("\s" * 3) }.join("\n")
      end

      def invalid_move?(x:, y:)
        [x, y].any?(&:negative?) || map.shape.dig(y, x).nil?
      end

      def find_overlapping(entity)
        entities.select { |e| e != entity && overlapping?(entity, e) }
      end

      private

      def overlapping?(entity, other)
        entity.x == other.x && entity.y == other.y
      end

      def validate_entity(entity)
        entity.add_error('Could not add entity (invalid class)') unless valid_entity_class?(entity)
        entity.add_error('Could not add entity (duplicate)') if duplicate_entity?(entity)
        require 'pry';binding.pry
      end

      def valid_entity_class?(entity)
        [
          Characters::Player,
          Characters::Npc,
          Characters::Enemy,
          Items::Weapon,
          Items::Armour
        ].any? { |klass| [entity.class, entity.class.superclass].include?(klass) }
      end

      def duplicate_entity?(entity)
        entities.include?(entity)
      end
    end
  end
end
