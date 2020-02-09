## `Game::Engine`
- Smart, controls the game
- contains game state
- instantiates other objects, eg: `Game::Window`, `Game::Map`, `Characters::Player`, `Game::Config`, `Game::State`
- single source of truth
- decides what happens and when
- recieves & parses input from other dumb classes
- triggers methods of other objects, eg `draw_current_state` -> `$window.draw(@current_state)`

## `Game::Window`
- receives instructions from `Engine`
- `draw()` when triggered will render map all entities to screen
- has its own local logic to validate when drawing
- `redraw?` "https://www.rubydoc.info/github/gosu/gosu/master/Gosu/Window#needs_redraw%3F-instance_method"
- `keypress`, `button_down`, `button_up` to receive input


## The Game `loop`
- Initialize Game ...
- Load current `@state`
- ->  `input()`
- |   `parse()` -> Game logic, validations
- |   `draw()`
- <- `input()`
- Exit Game


movement
- starting position
- `moveX`, `moveY`
- turn left, right
- turn around
- speed
- handle collisions
- handle edge of map
- calculate collisions

interacting with other objects
- interactable objects and not
- interact if same coordinates / within radius
- random generation of other objects

persisting data
- character customisation
- saved games
- load previous games


items
- base stats
- modifiers
- selling items / buying items
- magic find & item drops
- when can items be used?

npcs
- enemies vs friends
- normal enemies & special enemies
- base attributes & modifiers

hero character
- base stats & attributes
- skill points, progression, experience

battle
- same square as enemy = battle
- battle opens battle screen (pokemon / Final Fantatsystyle)
- any enemies within range will enter same battle

# Resources

### Gosu
https://github.com/gosu/gosu/wiki/Ruby-Tutorial


### TTY gem
https://ttytoolkit.org/
- TTY Box: https://www.rubydoc.info/gems/tty-box
- TTY Reader: https://github.com/piotrmurach/tty-reader
- TTY Prompt: https://github.com/piotrmurach/tty-prompt
- TTY Screen: https://github.com/piotrmurach/tty-screen

### Developing Games With Ruby
https://leanpub.com/developing-games-with-ruby/read

### Game Programming Patterns
http://gameprogrammingpatterns.com/

### ruby-prof gem
https://github.com/ruby-prof/ruby-prof

### RPG Maker 'Tsukuru'

https://en.wikipedia.org/wiki/RPG_Maker
