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
require 'hiro/game/state'
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
    @prompt = TTY::Prompt.new
  end

  def test_game
    options = @options.dup
    options.merge!(mode: 'test', game_state: { map: 'home', entities: [] })
    Hiro::Game::Engine.new(options)
  end

  def new_game
    name = prompt.ask('Welcome to Hiro. \n What would you like to call your player?')
    Hiro::Game::Engine.new(player: { name: name })
  end

  def load_saved_games
    Dir .entries(Hiro::Constants::SAVED_GAMES_PATH)
        .select { |f| f.match(/.yml$/) }
        .map { |g| g.gsub('.yml', '') }
  rescue StandardError => e
    p "Oops, something went wrong loading saved data: #{e}"
  end

  def resume_game?
    prompt.yes?("Would you like to resume your game (#{config[:current_player]})?")
  end

  private

  def load_config
    config_file = File.join(Hiro::Constants::ROOT, 'config.yml')
    return YAML.load_file(config_file) if File.exist?(config_file)

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
    File.open(File.join(Hiro::Constants::ROOT, 'config.yml'), 'w+') do |f|
      f.write(default_config.to_yaml)
    end

    config
  end

  def default_config
    { save: 'auto', mode: 'normal', current_player: nil }
  end

  def select_player_from_menu
  end
end

# Entry Point
if __FILE__ == $PROGRAM_NAME
  p 'Starting Hiro ...'

  init = Initializer.new
  if ARGV.any?
    return init.test_game if ARGV.include? '--test' unless ARGV.length > 1

    puts 'Error: Invalid number of command line arguments.'
    puts "Try 'ruby hiro.rb --test' to run in test mode"
    exit(0)
  end

  current_player = init.config.dig(:current_player)
  saved_games = init.load_saved_games

  if current_player && saved_games.include?(current_player)
    init.options.merge!(player: current_player) if init.resume_game?
  end

  unless init.options.dig(:player)
    return init.new_game if saved_games.empty?

    init.select_player_from_menu(saved_games) unless init.options[:player]
  end

  Hiro::Game::Engine.new(init.options)
end
