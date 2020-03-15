require 'tty-reader'

module Hiro
  module Game
    class Engine
      include Game::Errors
      attr_reader :window, :player, :mode, :state, :enemies, :reader
      def initialize(player:, state:, mode: 'normal')
        @state = Game::State.new(state)
        @window = Game::Window.new(state.fetch(:window))
        @player = Characters::Player.new(player)
        @enemies = []
        @mode = mode
        @reader = TTY::Reader.new

        super(self)
      end

      def run
        # temporary error checking & printing at runtime to make sure there are no silent failures
        # will replace with error propogation inside game loop when I decide where the errors should be handled
        return [state, window, player].flat_map(&:error_messages).map { |m| puts m } unless valid_game?

        p "Started Hiro with Player: #{player.inspect} ..."

        game_loop
      end

      def game_loop
        draw
        input
        game_loop
      end

      def input
        key_input = reader.read_keypress
        parse_keypress(key_input)
        overlapping = find_overlapping(player)
        combat(overlapping) unless overlapping.empty?
      end

      def combat(enemies)
        @state.is_in_combat = true
        while in_combat?
          player_combat_turn(enemies)
          enemies.each { |enemy| enemy_combat_turn(enemy) if enemy.alive? }
        end
      end

      def player_combat_turn(enemies)
        action = combat_menu(enemies)
        parse_combat_action(action)
      end

      def enemy_combat_turn(enemy)
        return unless enemy.can_attack?

        action = { type: 'attack', attacker: enemy, defenders: [player], method: enemy.weapon }
        parse_combat_action(action)
      end

      def parse_combat_action(type:, attacker:, defenders:, method:)
        "#{type} by #{attacker} against #{defenders.join(' & ')} using #{method}!!!"
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
        [state, window, player].all?(&:valid?)
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

      def in_combat?
        @state.is_in_combat
      end
    end
  end
end
