# frozen_string_literal: true

# Gem dependencies
require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'tty-prompt'

# Load lib
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'support/hash'
require 'hiro/constants'
require 'hiro/game/errors'
require 'hiro/game/errors/file_not_found'
require 'hiro/game/engine'
require 'hiro/game/window'
require 'hiro/game/map'
require 'hiro/game/locations'
require 'hiro/characters/player'
require 'hiro/characters/enemy'
require 'hiro/characters/npc'
require 'hiro/items/weapon'
require 'hiro/items/sword'
require 'hiro/items/armour'
require 'hiro/items/chest'

class Initializer
  attr_reader :prompt, :config, :saved_games
  attr_accessor :options

  def initialize
    @options = load_config.deep_symbolize_keys
    @saved_games = load_saved_games
    @prompt = TTY::Prompt.new
  end

  def load_config
    path = File.join(Hiro::Constants::ROOT, 'config.yml')
    YAML.load_file(path)
  end

  def test_game
    options = @options.dup
    options.merge!(mode: 'test', state: 'test_state')
    Hiro::Game::Engine.new(options)
  end

  def new_game
    options = @options.dup
    Hiro::Game::Engine.new(options)
  end

  def load_saved_games
    Dir .entries(Hiro::Constants::SAVED_GAMES_PATH)
        .select { |f| f.match(/.yml/) }
        .map { |g| g.gsub('.yml', '') }
  rescue StandardError => e
    p "Oops, something went wrong loading saved data: #{e}"
  end

  private

  def default_options
    {
      map: Array.new(10) { Array.new(10) { [' '] } },
      state: nil,
      mode: 'normal'
    }
  end

end

# Entry Point
if __FILE__ == $PROGRAM_NAME
  p 'Starting Hiro ...'

  init = Initializer.new
  if ARGV.any?
    return init.test_game if ARGV.include? '--test'

    p "'ruby hiro.rb --test' to run in test mode"
    exit(0)
  end

  return init.new_game if init.saved_games.empty?

  init.select_player_from_menu(init.saved_games) unless init.options[:player]
  require 'pry';binding.pry
  Hiro::Game::Engine.new(init.options)
end
