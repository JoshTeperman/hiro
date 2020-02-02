FactoryBot.define do
  factory :player, class: Hiro::Characters::Player do
    name { 'Hiro' }
    life { 10 }
    mana { 10 }
    character_level { 1 }
    location { Game::Locations::HOME }
    attributes do
      {
        max_life: 5,
        max_mana: 5,
        strength: 5,
        dexterity: 5,
        vitality: 5,
        intelligence: 5,
      }
    end
  end
end
