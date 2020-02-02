require 'dry-monads'

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
        new_entities.each do |entity|
          return entities << entity if can_add_entity?(entity)

          entities.add_error("Entity #{entity} could not be added to Window", :entity)
        end

        entities.valid? ? Dry::Monads::Success(entities) : Dry::Monads::Failure(entities)
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
