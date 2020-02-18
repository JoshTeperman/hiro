module Hiro
  module Game
    class Engine
      include Game::Errors
      attr_reader :window, :player, :mode, :game_state

      def initialize(player:, game_state:, mode: 'normal')
        @game_state = Game::State.new(game_state)
        @window = Game::Window.new(map: game_state.dig(:map), entities: game_state.dig(:entities))
        @player = Characters::Player.new(player)
        @mode = mode

        super(self)
      end
    end
  end
end
