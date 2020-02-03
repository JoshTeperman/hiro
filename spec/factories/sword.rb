FactoryBot.define do
  sword_params = {
    weapon_class_attributes: { type: 'Long Sword', min_damage: 2, max_damage: 10, max_base_damage: 4 },
    name: 'Grandfather',
    min_character_level: 1,
    range: 1
  }

  factory :sword, class: Hiro::Items::Sword do
    skip_create
    initialize_with { new(sword_params) }
  end
end
