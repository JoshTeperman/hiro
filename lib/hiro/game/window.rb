# frozen_string_literal: true

require 'dry-monads'

module Hiro
  module Game
    class Window
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :map, :entities

      def initialize(map:, entities: [])
        @map = map
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
