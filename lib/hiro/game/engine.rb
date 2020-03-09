require 'tty-reader'

module Hiro
  module Game
    class Engine
      include Game::Errors
      attr_reader :window, :player, :mode, :game_state, :enemies, :reader
      def initialize(player:, game_state:, mode: 'normal')
        @game_state = Game::State.new(game_state)
        @window = Game::Window.new(game_state.fetch(:window))
        @player = Characters::Player.new(player)
        @enemies = []
        @mode = mode
        @reader = TTY::Reader.new

        super(self)
      end

      def run
        # temporary error checking & printing at runtime to make sure there are no silent failures
        # will replace with error propogation inside game loop when I decide where the errors should be handled
        return [game_state, window, player].flat_map(&:error_messages).map { |m| puts m } unless valid_game?

        p "Started Hiro with Player: #{player.inspect} ..."

        game_loop
      end

      def game_loop
        parse_input
        draw

        game_loop
      end

      def parse_input
        input = reader.read_keypress
        parse_keypress(input)
      end

      def parse_keypress(key)
        case key
        when "\e[A"
          try_move(:up)
        when "\e[B"
          try_move(:down)
        when "\e[D"
          try_move(:left)
        when "\e[C"
          try_move(:right)
        when 'q'
          exit(0)
        when "\e"
          exit(0)
        else
          p key
        end
      end

      def valid_game?
        [game_state, window, player].all?(&:valid?)
      end

      def draw
        window.add_entities([player, *enemies])
        window.draw
      end

      def try_move(direction)
        updated_coordinate = player.public_send(direction)
        coordinates = { x: player.x, y: player.y }.merge(updated_coordinate)
        return if window.invalid_move?(coordinates)

        player.move(coordinates)
      end
    end
  end
end
