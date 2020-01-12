module Hiro
  module Items
    RSpec.describe Weapon do
      subject do
        described_class.new(
          weapon_class: weapon_class,
          name: name,
          min_character_level: min_character_level,
          range: range,
        )
      end

      let(:weapon_class) { instance_double(Sword, type: 'Long Sword', min_damage: 2, max_damage: 10, max_base_damage: 4) }
      let(:name) { 'Godfather' }
      let(:min_character_level) { 25 }
      let(:range) { 2 }

      describe '#initialize' do
        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.weapon_class).to eq weapon_class
            expect(subject.name).to eq name
            expect(subject.min_character_level).to eq min_character_level
            expect(subject.range).to eq range
            expect(subject.base_damage).to be_between(weapon_class.min_damage, weapon_class.max_base_damage)
          end
        end
      end

      describe '#roll_base_damage' do
        let(:min_damage) { 2 }
        let(:max_base_damage) { 10 }
        let(:weapon_class) { OpenStruct.new(min_damage: min_damage, max_base_damage: max_base_damage) }

        it 'sets a random base damage between min_damage and max_base_damage' do
          expect(subject.roll_base_damage).to be_between(min_damage, max_base_damage)
        end
      end

      describe '#calculate_modified_damage' do
        # TODO: Calculate on top of base damage
      end

      describe '#equip' do
      end

      describe '#unequip' do
      end

      describe '#drop' do
      end
    end
  end
end
