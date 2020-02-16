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
    @config = load_config.deep_symbolize_keys
    @options = {}
    @saved_games = load_saved_games
    @prompt = TTY::Prompt.new
  end

  def test_game
    options = @options.dup
    options.merge!(mode: 'test', game_state: { map: 'home' })
    Hiro::Game::Engine.new(options)
  end

  def new_game
    options = @options.dup
    Hiro::Game::Engine.new(options)
  end

  private

  def load_config
    file = File.join(Hiro::Constants::ROOT, 'config.yml')
    return YAML.load_file(file) if File.exist?(file)

    create_config
  end

  def default_options
    {
      map: Array.new(10) { Array.new(10) { [' '] } },
      game_state: nil,
      mode: 'normal'
    }
  end

  def create_config
    config = default_config
    File.open(File.join(Hiro::Constants::ROOT, 'config.yml'), 'w+') do |f|
      f.write(config.to_yaml)
    end

    config
  end

  def default_config
    { save: 'auto', mode: 'normal', current_player: nil }
  end

  def load_saved_games
    Dir .entries(Hiro::Constants::SAVED_GAMES_PATH)
        .select { |f| f.match(/.yml/) }
        .map { |g| g.gsub('.yml', '') }
  rescue StandardError => e
    p "Oops, something went wrong loading saved data: #{e}"
  end
end

# Entry Point
if __FILE__ == $PROGRAM_NAME
  p 'Starting Hiro ...'

  init = Initializer.new
  if ARGV.any?
    return init.test_game if ARGV.include? '--test' unless ARGV.length > 1

    puts 'Error: Invalid number of command line arguments.'
    p "Try 'ruby hiro.rb --test' to run in test mode"
    exit(0)
  end

  return init.new_game if init.saved_games.empty?

  init.select_player_from_menu(init.saved_games) unless init.options[:player]

  Hiro::Game::Engine.new(init.options)
end
