FactoryBot.define do
  enemy_params = {
    x: 0,
    y: 0,
    life: 10,
    level: 1,
    strength: 5,
    dexterity: 5,
    defense: 5
  }

  factory :enemy, class: Hiro::Characters::Enemy do
    skip_create
    initialize_with { new(enemy_params) }
  end
end
