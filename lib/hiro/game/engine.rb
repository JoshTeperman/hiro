require 'tty-reader'

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
        @reader = TTY::Reader.new

        super(self)
      end

      def run
        ENV['RUN_GAME'] = 'true'
        # temporary error checking & printing at runtime to make sure there are no silent failures
        # will replace with error propogation inside game loop when I decide where the errors should be handled
        return [game_state, window, player].flat_map(&:error_messages).map { |m| puts m } unless valid_game?

        p "Started Hiro with Player: #{@player.inspect} ..."

        game_loop
      end

      def game_loop
        parse_input
        draw

        game_loop
      end

      def parse_input
        input = @reader.read_keypress
        parse_keypress(input)
      end

      def parse_keypress(key)
        case key
        when "\e[A"
          player.move_up
        when "\e[B"
          player.move_down
        when "\e[D"
          player.move_left
        when "\e[C"
          player.move_right
        when 'q'
          exit(0)
        else
          p key
        end
      end

      def valid_game?
        [game_state, window, player].all?(&:valid?)
      end

      def draw
        window.add_entities([player]) unless window.entities.include?(player)
        window.draw
      end
    end
  end
end
