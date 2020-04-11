# frozen_string_literal: true

require 'tty-box'
require 'tty-screen'

module Hiro
  module Game
    class Window
      include Game::Errors

      attr_reader :map, :entities, :player, :screen, :box

      def initialize(map:, player:, entities: [])
        @map = Game::Map.new(map_name: map)
        @entities = entities
        @player = player
        @screen = TTY::Screen
        @box = TTY::Box

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
        system('clear')

        screen_height = screen.height
        screen_width = screen.width

        main_height = screen_height - 1
        main_width = screen_width
        main_left = 0
        main_top = 0

        map_container_height = main_height
        map_container_width = main_width / 2
        map_container_top = 0
        map_container_left = 0

        action_container_height = main_height / 3
        action_container_width = main_width / 2
        action_container_left = main_width / 2 - 1
        action_container_top = main_top

        action_container_2_height = main_height / 3
        action_container_2_width = main_width / 2
        action_container_2_left = main_width / 2 - 1
        action_container_2_top = main_top + action_container_height

        action_container_3_height = main_height - (action_container_height + action_container_2_height)
        action_container_3_width = main_width / 2
        action_container_3_left = main_width / 2 - 1
        action_container_3_top = action_container_2_top + action_container_height

        stats_container_height = main_height / 4
        stats_container_width = main_width / 2
        stats_container_top = main_height - stats_container_height
        stats_container_left = main_left

        map_container = box.frame(
          top: map_container_top,
          left: map_container_left,
          height: map_container_height,
          width: map_container_width,
          padding: [1, 2],
          title: { top_left: ' MAP: HOME '}
        ) do
          prepare_map_string
        end

        stats_container = box.frame(
          top: stats_container_top,
          left: stats_container_left,
          height: stats_container_height,
          width: stats_container_width,
          title: {
            top_left: ' PLAYER STATS ',
            top_right: " #{player.name.upcase} "
          }
        )

        action_container = box.frame(
          top: action_container_top,
          left: action_container_left,
          height: action_container_height,
          width: action_container_width,
          title: { top_left: ' ACTION CONTAINER ' }
        )

        action_container_2 = box.frame(
          top: action_container_2_top,
          left: action_container_2_left,
          height: action_container_2_height,
          width: action_container_2_width,
          title: { top_left: ' ACTION CONTAINER 2 ' }
        )

        action_container_3 = box.frame(
          top: action_container_3_top,
          left: action_container_3_left,
          height: action_container_3_height,
          width: action_container_3_width,
          title: { top_left: ' ACTION CONTAINER 3 ' }
        )

        print map_container
        print stats_container
        print action_container
        print action_container_2
        print action_container_3
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
