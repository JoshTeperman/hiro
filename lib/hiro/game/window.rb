# frozen_string_literal: true

require 'dry-monads'
require 'tty-box'

module Hiro
  module Game
    class Window
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :map, :entities

      def initialize(map:, entities: [])
        @map = Game::Map.new(map_name: map)
        @entities = entities
        super(self)
      end

      def add_entities(new_entities)
        new_entities.each do |entity|
          unless can_add_entity?(entity)
            entity.add_error('Could not add entity to Window')

            return Dry::Monads::Failure(entity)
          end
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
        entities.map do |e|
          case e.class.to_s
          when Characters::Player.to_s
            map.shape[e.x][e.y] = '*'
          when Characters::Enemy.to_s
            map.shape[e.x][e.y] = 'O'
          end
        end

        map.shape.map { |row| row.join("\s" * 3) }.join("\n")
      end

      private

      def can_add_entity?(entity)
        [
          Characters::Player,
          Characters::Npc,
          Characters::Enemy,
          Items::Weapon,
          Items::Armour
        ].any? { |klass| [entity.class, entity.class.superclass].include?(klass) }
      end
    end
  end
end
