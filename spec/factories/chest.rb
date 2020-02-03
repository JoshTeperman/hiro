FactoryBot.define do
  chest_params = {
    armour_class_attributes: { type: 'Cloak', min_defense: 2, max_defense: 4 },
    name: "Prince's Purple Jacket",
    min_character_level: 1,
  }

  factory :chest, class: Hiro::Items::Chest do
    skip_create
    initialize_with { new(chest_params) }
  end
end
