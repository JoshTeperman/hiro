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

      def add_entity(entity)
        if entities << entity
          Dry::Monads::Success(entities)
        else
          add_error('Failed to add entity', :entities)
          Dry::Monads::Failure(self)
        end
      end
    end
  end
end
