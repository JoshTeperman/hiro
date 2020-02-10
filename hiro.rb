# Gem dependencies
require 'rubygems'
require 'bundler/setup'
require 'yaml'

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

if __FILE__ == $PROGRAM_NAME
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
    initialize_test_game if ENV['hiro_env'] == 'TEST'
    saved_games = load_saved_games
    new_game if saved_games.empty?
  rescue => e
    p "Oops, something went wrong: #{e}"
  end
end

private

def initialize_test_game
  Game::Engine.new(
    player: load_test_player,
    map: Array.new(10) { Array.new(10) { [' '] } }
  )
end

def new_game
  Game::Engine.new(map: Locations::HOME)
end

def load_saved_games
  Dir .entries(SAVED_GAME_PATH)
      .select { |f| f.match(/.yml/) }.map(&:split)
      .map { |game| game.gsub('.yml', '') }
end
