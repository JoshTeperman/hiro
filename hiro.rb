# the lib/hiro.rb file is for setting up environment, loading dependencies, defines the Hiro Module and is the entry point for the application.

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'

require 'hiro/game/engine'
require 'hiro/game/errors'
require 'hiro/characters/player'
require 'hiro/items/weapon'
require 'hiro/items/sword'
require 'hiro/items/armour'
require 'hiro/items/chest'

if ARGV.any?
  p 'Command line arguments are not supported yet'
  exit(0)
end

module Hiro
  module Game
    begin
      p 'Starting Hiro ...'
      Engine.new
    rescue => e
      p "Oops, something went wrong: #{e}"
    end
  end
end
