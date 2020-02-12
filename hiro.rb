# frozen_string_literal: true

# Gem dependencies
require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'tty-prompt'

# Load lib
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

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
  attr_reader :prompt, :config
  attr_accessor :options

  def initialize
    @options = default_options
    @prompt = TTY::Prompt.new
    @config = load_config
  end

  def test_game
    options = @options.dup
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

  def resume_game_prompt
    require 'pry';binding.pry
    player = ENV['Player']
    answer = prompt.yes?("Would you like to resume your game as #{player}?")
    options[:player] = player if answer == 'y'

    options
  end

  private

  def default_options
    {
      map: Array.new(10) { Array.new(10) { [' '] } },
      state: nil,
    }
  end

  def load_config
    path = File.join(Hiro::Constants::ROOT, 'config.yml')
    YAML.load_file(path)
  end
end

# Entry Point
if __FILE__ == $PROGRAM_NAME
  init = Initializer.new
  p 'Starting Hiro ...'

  if ARGV.any?
    if ARGV.include? '--test'
      ENV['hiro_env'] = 'TEST'
    else
      p "'ruby hiro.rb --test' to run in test mode"
      exit(0)
    end
  end

  saved_games = init.load_saved_games

  return init.test_game if ENV['hiro_env'] == 'TEST'
  return init.new_game if saved_games.empty? && !ENV['Player']

  init.resume_game_prompt if ENV['Player']
  init.select_player_from_menu(saved_games) unless init.options[:player]

  Engine.new(init.options)
end
