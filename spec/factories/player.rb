FactoryBot.define do
  player_params = {
    name: 'Hiro',
          life: 10,
          mana: 10,
          character_level: 1,
          location: Hiro::Game::Locations::HOME,
          attributes: {
            max_life: 5,
            max_mana: 5,
            strength: 5,
            dexterity: 5,
            vitality: 5,
            intelligence: 5,
          }
  }

  factory :player, class: Hiro::Characters::Player do
    skip_create
    initialize_with { new(player_params) }
  end
end
