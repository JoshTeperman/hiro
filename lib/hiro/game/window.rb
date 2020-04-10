# frozen_string_literal: true

require 'tty-box'
require "tty-cursor"

module Hiro
  module Game
    class Window
      include Game::Errors

      attr_reader :map, :entities, :player, :cursor

      def initialize(map:, player:, entities: [])
        @map = Game::Map.new(map_name: map)
        @entities = entities
        @player = player
        @cursor = TTY::Cursor
        super(self)
      end

      def add_entities(new_entities)
        new_entities.each do |entity|
          validate_entity(entity)
          # TODO: log error if invalid
          entities << entity if entity.valid?
        end
        entities
      end

      def clear
        @entities = []
      end

      def draw(actions: [])
        map = prepare_map_string
        stats = " life: #{player.life} "
        map_box = TTY::Box.frame(
          map,
          top: 2,
          left: 0,
          padding: [0, 1],
          title: { bottom_left: stats },
          border: :thick,
        )
        content2 = TTY::Box.frame(
          actions.join("\n"),
          top: 2,
          width: 50,
          height: 10,
          left: 51,
          padding: [0, 1],
          title: { bottom_left: " character level: #{player.character_level} " }
        )
        print map_box
        print content2
        puts
      end

      def prepare_map_string
        map_copy = map.shape.deep_dup
        entities.map do |e|
          case e.class.to_s
          when Characters::Player.to_s
            map_copy[e.y][e.x] = '*'
          when Characters::Enemy.to_s
            map_copy[e.y][e.x] = 'O'
          end
        end

        map_copy
          .map { |row| row.join("\s" * 2) }
          .join("\n")
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
        # Validating to catch bugs. Invalid entity should not break the game.
        entity.add_error('Could not add entity (invalid class)') unless valid_entity_class?(entity)
        entity.add_error('Could not add entity (duplicate)') if duplicate_entity?(entity)
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
