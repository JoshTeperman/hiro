module Hiro
  module Game
    class Engine
      include Game::Errors
      attr_reader :window, :player, :mode, :game_state
      def initialize(player:, game_state:, mode: 'normal')
        @game_state = Game::State.new(game_state)
        @window = Game::Window.new(game_state.fetch(:window))
        @player = Characters::Player.new(player)
        @mode = mode

        super(self)
      end

      def run
        p "Started Hiro with #{@player.inspect} ..."
      end
    end
  end
end
