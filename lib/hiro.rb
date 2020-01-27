lib = (File.expand_path('../lib', __dir__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pry';binding.pry
require 'hiro/version'
require 'hiro/game/engine'
require 'hiro/game/errors'
require 'hiro/characters/player'
require 'hiro/items/weapon'
require 'hiro/items/sword'
require 'hiro/items/armour'
require 'hiro/items/chest'

begin
  p 'Starting Hiro ...'
  Engine.new
rescue => e
  p "Oops, something went wrong: #{e}"
end
