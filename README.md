## To consider

game state
- `Game` class
- global variables
- current map
- player stats
- settings

some kind of `draw()` function
- calculate collisions
- move objects around
- (x, y) coordinates

drawing the window
- `Game::Window` class
- window size
- fullscreen
- show / hide panels
- captions / text
- redraw check "https://www.rubydoc.info/github/gosu/gosu/master/Gosu/Window#needs_redraw%3F-instance_method"

movement
- starting position
- keypress, button_down, button_up
- `moveX`, `moveY`
- turn left, right
- turn around
- speed
- handle collisions
- handle edge of map

interacting with other objects
- interactable objects and not
- interact if same coordinates / within radius
- random generation of other objects

persisting data
- character customisation
- saved games
- load previous games

items
- composition vs inheritance
- base stats
- modifiers
- selling items / buying items
- magic find & item drops
- when can items be used?

npcs
- composition vs inheritance
- enemies vs friends
- normal enemies & special enemies
- base attributes & modifiers

hero character
- base stats & attributes
- skill points, progression, experience

battle
- same square as enemy = battle
- battle opens battle screen (pokemon style)
- any enemies within range will enter same battle

# Resources

### Gosu
https://github.com/gosu/gosu/wiki/Ruby-Tutorial

### TTY gem

https://ttytoolkit.org/

### Developing Games With Ruby
https://leanpub.com/developing-games-with-ruby/read

### Game Programming Patterns
http://gameprogrammingpatterns.com/

### ruby-prof gem
https://github.com/ruby-prof/ruby-prof

### RPG Maker 'Tsukuru'

https://en.wikipedia.org/wiki/RPG_Maker
