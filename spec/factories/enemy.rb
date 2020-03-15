FactoryBot.define do
  enemy_params = {
    x: 0,
    y: 0,
    name: 'Test Enemy Name',
    level: 1,
    enemy_class_attributes: {
      type: 'test',
      min_vitality: 1,
      max_vitality: 5,
      min_damage: 1,
      max_damage: 5,
      min_dexterity: 1,
      max_dexterity: 5,
      min_defense: 1,
      max_defense: 10,
    },
  }

  factory :enemy, class: Hiro::Characters::Enemy do
    skip_create
    initialize_with { new(enemy_params) }
  end
end
