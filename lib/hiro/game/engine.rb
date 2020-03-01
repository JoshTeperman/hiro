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
        # temporary error checking & printing at runtime to make sure there are no silent failures
        # will replace with error propogation inside game loop when I decide where the errors should be handled
        return [game_state, window, player].flat_map(&:error_messages).map { |m| puts m } unless valid_game?

        p "Started Hiro with #{@player.inspect} ..."
      end

      def valid_game?
        [game_state, window, player].all?(&:valid?)
      end
    end
  end
end
