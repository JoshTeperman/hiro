require 'tty-reader'
require 'tty-prompt'

module Hiro
  module Game
    class Engine
      include Game::Errors
      attr_reader :player, :mode, :reader, :state, :window, :key_events, :prompt

      def initialize(player:, current_map:, enemy_data:, mode: 'normal')
        @state = Game::State.new(
          current_map: current_map,
          enemy_data: enemy_data,
          last_player_coordinates: { x: player[:x], y: player[:y] }
        )
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

        p 'Started Hiro...'
        if test_mode?
          p 'Loading game in test mode ...'
        else
          p "Loading Character '#{player.name}'..."
        end

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
        process_kills
      end

      def process_kills
        kills = state.kills
        return if kills.empty?

        p "You killed #{kills.map(&:name).join(', ')}"
        p 'your reward is <REWARD>'
        state.clear_killed_enemies
      end

      def combat(enemies)
        state.is_in_combat = true
        while in_combat?
          if enemies.any?(&:alive?)
            player_combat_turn(enemies.first)
            return unless in_combat?

            enemies.filter(&:alive?).each do |enemy|
              enemy_combat_turn(enemy)
              handle_player_death(enemy: enemy) if player.dead?
            end
          else
            state.is_in_combat = false
          end
        end
      end

      def handle_player_death(enemy:)
        p "You were killed by #{enemy.name}."
        p 'load last saved game (y/n)' if prompt.ask('Load last saved game?') == 'y'
        p 'Thanks for playing, goodbye 👋'
        exit(0)
      end

      def player_combat_action_selection_menu
        options = ['attack', 'run away']
        prompt.select('Choose a combat action:', options)
      end

      def player_combat_turn(enemy)
        p "Battle against #{enemy.name} (#{enemy.life} life)"
        combat_action = player_combat_action_selection_menu
        parse_combat_action(action: combat_action, attacker: player, defender: enemy)
      end

      def parse_combat_action(action:, attacker:, defender:)
        case action
        when 'attack'
          p "#{attacker.name} attacked #{defender.name} with #{attacker.weapon.name}"
          calculate_attack(attacker: attacker, defender: defender)
        when 'run away'
          p 'you ran away'
          state.is_in_combat = false
          player.move(state.last_player_coordinates)
        end
      end

      def calculate_attack(defender:, attacker:)
        attack_damage = attacker.weapon.roll_attack_damage
        defender.lose_life(attack_damage)
        p "⚔️  Attack dealt #{attack_damage} damage to #{defender.name}"
        p "❤️  #{defender.life} life remaining" if defender.alive?
      end

      def enemy_combat_turn(enemy)
        p 'enemy combat turn'
        parse_combat_action(action: 'attack', attacker: enemy, defender: player)
        if !player.alive?
          state.is_in_combat = false
        end
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
        when 'Q'
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

        state.last_player_coordinates = { x: player.x, y: player.y }
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

      def test_mode?
        mode == 'test'
      end
    end
  end
end
