# Gem dependencies
require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'tty-prompt'

# App files
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

# Entry Point


def initialize_test_game
  Hiro::Game::Engine.new(
    map: Array.new(10) { Array.new(10) { [' '] } }
  )
end

def initialize_saved_game
end

def new_game
  Hiro::Game::Engine.new(map: Hiro::Game::Locations::HOME)
end

def load_saved_games
  Dir .entries(Hiro::Constants::SAVED_GAMES_PATH)
      .select { |f| f.match(/.yml/) }
      .map { |g| g.gsub('.yml', '') }
end

if __FILE__ == $PROGRAM_NAME
  prompt = TTY::Prompt.new

  p 'Starting Hiro ...'

  if ARGV.any?
    if ARGV.include? '--test'
      ENV['hiro_env'] = 'TEST'
    else
      p "'ruby hiro.rb --test' to run in test mode"
      exit(0)
    end
  end

  begin
    return initialize_test_game if ENV['hiro_env'] == 'TEST'

    saved_games = load_saved_games
    return new_game if saved_games.empty?

    available_game_options = saved_games.push('New Player')

    selected_game = prompt.select('Select an option to begin: ', available_game_options)
    return new_game if selected_game == 'New Player'

    initialize_saved_game(selected_game)
  rescue => e
    p "Oops, something went wrong: #{e}"
  end
end
