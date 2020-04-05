FactoryBot.define do
  sword_params = {
    weapon_class_attributes: {
      type: 'Long Sword',
      min_minimum_damage: 2,
      max_minimum_damage: 4,
      min_maximum_damage: 4,
      max_maximum_damage: 10,
    },
    name: 'Grandfather',
    min_character_level: 1,
  }

  factory :sword, class: Hiro::Items::Sword do
    skip_create
    initialize_with { new(sword_params) }
  end
end
