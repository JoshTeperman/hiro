# Gem dependencies
require 'rubygems'
require 'bundler/setup'

# App files
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hiro/game/engine'
require 'hiro/game/window'
require 'hiro/game/errors'
require 'hiro/game/locations'
require 'hiro/characters/player'
require 'hiro/items/weapon'
require 'hiro/items/sword'
require 'hiro/items/armour'
require 'hiro/items/chest'

# Entry Point

if __FILE__ == $PROGRAM_NAME
  if ARGV.any?
    p 'Command line arguments are not supported yet'
    exit(0)
  end

  begin
    p 'Starting Hiro ...'
    Hiro::Game::Engine.new
  rescue => e
    p "Oops, something went wrong: #{e}"
  end
end
