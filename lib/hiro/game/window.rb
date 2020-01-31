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

      def add_entity(entities)
        entities.each do |entity|
          entity.add_error('Failed to add entity', :entity) unless can_add_entity?(entity)
          entities << entity
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
