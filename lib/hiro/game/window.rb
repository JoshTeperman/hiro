require 'dry-monads'
require 'hiro/game/errors_spec'

module Hiro
  module Game
    class Window
      include Dry::Monads[:result]
      include Game::Errors

      attr_reader :map, :entities

      def initialize(map:)
        @map = map
        @entities = []
        super(self)
      end

      def add_entities(new_entities)
        entities.each do |entity|
          if can_add_entity?(entity)
            entities << entity
          else
            entity.add_error('Failed to add entity', :entity)
            return Failure(entity)
          end
          return Success(entities)
        end

        Dry::Monads::Success(entities)
      end

      private

      def can_add_entity?(entity)
        [
          Characters::Player,
          Characters::Npc,
          Items::Weapon,
          Items::Armour
        ].include?(entity.class)
      end
    end
  end
end
