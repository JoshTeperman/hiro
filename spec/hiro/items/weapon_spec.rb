require 'hiro/game/errors_spec'

module Hiro
  module Items
    RSpec.describe Weapon do
      subject do
        described_class.new(
          weapon_class_attributes: weapon_class_attributes,
          name: name,
          min_character_level: min_character_level,
        )
      end

      let(:weapon_class_attributes) do
        {
          type: type,
          min_minimum_damage: min_minimum_damage,
          max_minimum_damage: max_minimum_damage,
          min_maximum_damage: min_maximum_damage,
          max_maximum_damage: max_maximum_damage,
        }
      end

      let(:type) { 'Long Sword' }
      let(:name) { 'Godfather' }
      let(:min_character_level) { 25 }
      let(:min_minimum_damage) { 1 }
      let(:max_minimum_damage) { 2 }
      let(:min_maximum_damage) { 3 }
      let(:max_maximum_damage) { 10 }

      describe '#initialize' do
        it_behaves_like 'Errors'

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.weapon_class).to be_instance_of(Struct::WeaponClass)
            expect(subject.name).to eq name
            expect(subject.min_character_level).to eq min_character_level
            expect(subject.min_damage).to be_between(min_minimum_damage, max_minimum_damage)
            expect(subject.max_damage).to be_between(min_maximum_damage, max_maximum_damage)
          end
        end

        context 'when it has no name' do
          let(:name) { nil }

          it 'it returns the weapon class type' do
            expect(subject.name).to eq weapon_class_attributes[:type]
          end
        end

        describe 'weapon_class' do
          let(:weapon_class) { subject.weapon_class }

          it 'creates an instance of Struct::WeaponClass with the expected attributes' do
            aggregate_failures do
              expect(weapon_class.type).to eq type
              expect(weapon_class.min_minimum_damage).to eq min_minimum_damage
              expect(weapon_class.max_minimum_damage).to eq max_minimum_damage
              expect(weapon_class.min_maximum_damage).to eq min_maximum_damage
              expect(weapon_class.max_maximum_damage).to eq max_maximum_damage
            end
          end
        end
      end
    end
  end
end
