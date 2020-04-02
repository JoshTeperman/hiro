require 'tty-reader'
require 'tty-prompt'

module Hiro
  module Game
    class Engine
      include Game::Errors
      attr_reader :player, :mode, :reader, :state, :window, :key_events, :prompt

      def initialize(player:, current_map:, enemy_data:, mode: 'normal')
        @state = Game::State.new(current_map: current_map, enemy_data: enemy_data)
        @player = Characters::Player.new(player)
        @window = Game::Window.new(map: current_map)
        @mode = mode
        @reader = TTY::Reader.new
        @key_events = []
        @prompt = TTY::Prompt.new

        super(self)
      end

      def run
        # temporary error checking & printing at runtime to make sure there are no silent failures
        # will replace with error propogation inside game loop when I decide where the errors should be handled
        return [state, window, player].flat_map(&:error_messages).map { |m| puts m } unless valid_game?

        p "Started Hiro with Player: #{player.inspect} ..."

        draw_window
        game_loop
      end

      def game_loop
        input_events
        process_activity
        draw_window

        game_loop
      end

      def input_events
        clear_inputs
        receive_key_event(reader.read_keypress)
      end

      def process_activity
        parse_keypress(key_events)
        overlapping = window.find_overlapping(player)
        combat(overlapping) unless overlapping.empty?
      end

      def combat(enemies)
        state.is_in_combat = true
        while in_combat?
          # not handling multiple enemies for now
          player_combat_turn(enemies.first)
          return unless in_combat?

          enemies.each { |enemy| enemy_combat_turn(enemy) if enemy.alive? }
        end
      end

      def player_combat_menu(enemy)
        options = ['attack', 'run away']
        prompt.select('Choose a combat action:', options)
      end

      def player_combat_turn(enemy)
        p "Battle against #{enemy.name_or_type}"
        combat_action = player_combat_menu(enemy)
        parse_combat_action(action: combat_action, attacker: player, defender: enemy)
      end

      def parse_combat_action(action:, attacker:, defender:)
        case action
        when 'attack'
          p "#{attacker.name} attacked #{defender.name_or_type} with #{attacker.weapon.name_or_type}"
          result = calculate_attack(attacker: attacker, defender: defender)
        when 'run away'
          p 'you ran away'
          state.is_in_combat = false
        end
      end

      def calculate_attack(defender:, attacker:)
        attack_damage = attacker.weapon.roll_attack_damage
        defender.life -= attack_damage
        p "#{defender.name} lost #{attack_damage} life"
        p "#{defender.life} life remaining"
      end

      def enemy_combat_turn(enemy)
        action = {}
        parse_combat_action(action)
      end

      def receive_key_event(key_event)
        key_events.push(key_event)
      end

      def parse_keypress(key_inputs)
        return if key_inputs.empty?
        return add_error('Multiple key_events detected', :key_events) if key_inputs.length > 1

        key = key_inputs.last
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

      def draw_window
        window.clear
        window.add_entities([player, *state.enemies])
        window.draw
      end

      def try_move(direction)
        updated_coordinate = player.public_send(direction)
        coordinates = { x: player.x, y: player.y }.merge(updated_coordinate)
        return if window.invalid_move?(coordinates)

        player.move(coordinates)
      end

      def in_combat?
        state.is_in_combat
      end

      def enemies
        state.enemies
      end

      private

      def clear_inputs
        @key_events = []
      end
    end
  end
end
