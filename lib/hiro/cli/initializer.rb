# frozen_string_literal: true

require 'hiro'
require 'tty-prompt'
require 'yaml'

module Hiro
  module Cli
    class Initializer
      attr_reader :prompt

      def initialize(argv)
        @options = Struct::OptionsParser.new(argv).parse
        @state = {}
        @prompt = TTY::Prompt.new
      end

      def execute
        player_name = test_mode? ? 'test_player' : select_player_menu
        load_saved_game_data(player_name)
        # TODO: load game state and add to options
        Hiro::Game::Engine.new(**@options, **@state).run
      end

      private

      def test_mode?
        @options[:mode] == 'test'
      end

      def select_player_menu
        p 'Welcome to Hiro'
        available_saved_games = load_available_saved_games

        return new_game_prompt if available_saved_games.empty?

        # TODO: figure out how to know if name should be capitalized
        # TODO: convert '-' to spaces
        menu_options = [*available_saved_games, 'New Game', 'exit']
        answer = prompt.select('Load a saved game or create a new hero:', menu_options)

        case answer
        when 'New Game'
          new_game_prompt
        when 'exit'
          exit_program_with_message('thanks for playing')
        else
          answer
          # TODO: validation
        end
      end

      def new_game_prompt
        prompt.ask('What would you like to call your player?')
        # TODO: validation -> no special characters except for _-, whitespace ok
      end

      def load_config
        config_file = File.join(Hiro::Constants::ROOT, 'config.yml')
        return YAML.load_file(config_file) if File.exist?(config_file)

        create_config
      end

      def load_saved_game_data(name)
        path = test_mode? ? Hiro::Constants::TEST_PLAYER_PATH : Hiro::Constants::SAVED_GAMES_PATH
        file = File.join(path, "#{name}.yml")

        saved_game_data = File.exist?(file) ? YAML.load_file(file).deep_symbolize_keys : new_player_template(name)
        @state.merge!(saved_game_data)
      end

      def load_available_saved_games
        Dir
          .entries(Hiro::Constants::SAVED_GAMES_PATH)
          .select { |f| f.match(/.yml$/) }
          .map { |g| g.gsub('.yml', '') }
      rescue StandardError => e
        p "Oops, something went wrong loading saved data: #{e}"
      end

      def new_player_template(name)
        {
          player: {
            name: name,
            life: 10,
            mana: 10,
            character_level: 1,
            x: 0,
            y: 0,
            attributes: {
              max_life: 5,
              max_mana: 5,
              strength: 5,
              dexterity: 5,
              vitality: 5,
            }
          },
          state: { window: { map: 'home', entities: [] } }
        }
      end

      def exit_program_with_message(msg)
        p msg
        exit(0)
      end

      Struct.new('OptionsParser', :argv) do
        def parse
          return { mode: 'normal' } if argv.empty?

          if argv.length > 1
            exit_program_with_message('Error: Too many command line arguments.')
          else
            return { mode: 'test' } if argv.last == '--test'

            exit_program_with_message("Unrecognizable argument: #{argv.last}")
          end
        end
      end
    end
  end
end
