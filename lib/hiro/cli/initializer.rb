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
        @config = load_config.deep_symbolize_keys
        @saved_games = load_saved_games
        @prompt = TTY::Prompt.new
      end

      def execute
        game_menu unless @options[:mode] == 'test'
        Hiro::Game::Engine.new(@options).run
      end

      private

      def game_menu
        p 'Welcome to Hiro'
        @saved_games.empty? ? new_game_prompt : select_game_prompt
      end

      def new_game_prompt
        name = prompt.ask('What would you like to call your player?')
        @options.merge!({ player: {name: name}, game_state: {} })
      end

      def select_game_prompt
        menu_options = @saved_games << ['New Game', 'exit']
        answer = prompt.select('Load a saved game or create a new hero:', menu_options)

        case answer
        when 'New Game'
          new_game_prompt
        when 'exit'
          p 'thanks for playing'
          exit(0)
        else
          @options.merge!({ player: { name: answer }, game_state: {} })
        end
      end

      def load_config
        config_file = File.join(Hiro::Constants::ROOT, 'config.yml')
        return YAML.load_file(config_file) if File.exist?(config_file)

        create_config
      end

      def create_config
        config = default_config
        File.open(File.join(Hiro::Constants::ROOT, 'config.yml'), 'w+') do |f|
          f.write(config.to_yaml)
        end

        config
      end

      def default_config
        { mode: 'normal', save: 'auto' }
      end

      def load_saved_games
        Dir
          .entries(Hiro::Constants::SAVED_GAMES_PATH)
          .select { |f| f.match(/.yml$/) }
          .map { |g| g.gsub('.yml', '') }
      rescue StandardError => e
        p "Oops, something went wrong loading saved data: #{e}"
      end

      Struct.new('OptionsParser', :argv) do
        def parse
          return default_options if argv.empty?

          exit p 'Error: Too many command line arguments.' if argv.length > 1
          return test_options if argv.include?('--test')

          exit p "Unrecognizable argument: #{argv.last}"
        end

        def default_options
          {}
        end

        def test_options
          { mode: 'test', game_state: { map: 'home', entities: [] } }
        end
      end
    end
  end
end
