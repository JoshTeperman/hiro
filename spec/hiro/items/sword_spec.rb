require 'hiro/game/errors_spec'

module Hiro
  module Items
    RSpec.describe Sword do
      subject { described_class.new(params) }

      let(:params) do
        {
          weapon_class_attributes: weapon_class_attributes,
          name: name,
          min_character_level: min_character_level,
          range: range
        }
      end

      describe '#initialize' do
        let(:weapon_class_attributes) { { type: type, min_damage: min_damage, max_damage: max_damage, max_base_damage: max_base_damage } }
        let(:type) { 'Long Sword' }
        let(:min_damage) { 2 }
        let(:max_damage) { 10 }
        let(:max_base_damage) { 4 }

        let(:name) { 'Grandfather' }
        let(:min_character_level) { 1 }
        let(:range) { 2 }

        it_behaves_like 'Errors'

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has the correct attributes' do
          aggregate_failures do
            expect(subject.name).to eq name
            expect(subject.min_character_level).to eq min_character_level
            expect(subject.base_damage).to be_between(min_damage, max_base_damage)
            expect(subject.range).to eq range
          end
        end

        context 'when no range is given' do
          let(:params) do
            {
              weapon_class_attributes: weapon_class_attributes,
              name: name,
              min_character_level: min_character_level,
            }
          end

          it 'has a default range of 1' do
            expect(subject.range).to eq 1
          end
        end

        describe 'weapon_class' do
          let(:weapon_class) { subject.weapon_class }

          it 'creates an instance of Struct::WeaponClass' do
            expect(weapon_class).to be_instance_of(Struct::WeaponClass)
          end

          it 'has the the expected attributes' do
            expect(weapon_class.type).to eq type
            expect(weapon_class.min_damage).to eq min_damage
            expect(weapon_class.max_damage).to eq max_damage
            expect(weapon_class.max_base_damage).to eq max_base_damage
          end
        end
      end
    end
  end
end
