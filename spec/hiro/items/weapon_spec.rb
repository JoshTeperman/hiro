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

      let(:weapon_class) { OpenStruct.new(type: type, min_damage: min_damage, max_damage: max_damage, max_base_damage: max_base_damage) }
      let(:type) { 'Long Sword' }
      let(:min_damage) { 2 }
      let(:max_damage) { 10 }
      let(:max_base_damage) { 4 }

      let(:name) { 'Godfather' }
      let(:min_character_level) { 25 }
      let(:range) { 2 }
      let(:base_damage) { 5 }

      allow{ subject }.to receive(:weapon_class).and_return(weapon_class)

      describe '#initialize' do
        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.weapon_class).to eq weapon_class
            expect(subject.name).to eq name
            expect(subject.min_character_level).to eq min_character_level
            expect(subject.range).to eq range
            expect(subject.base_damage).to be_between(min_damage, max_base_damage)
          end
        end
      end

      describe 'weapon_class' do
        it 'returns a Struct with the expected attributes' do
          require 'pry';binding.pry
          aggregate_failures do
            expect(weapon_class.type).to eq type
            expect(weapon_class.min_damage).to eq min_damage
            expect(weapon_class.max_damage).to eq max_damage
            expect(weapon_class.max_base_damage).to eq max_base_damage
          end
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
