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
        }
      end

      describe '#initialize' do
        it_behaves_like 'Errors'

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
        let(:min_minimum_damage) { 2 }
        let(:max_minimum_damage) { 4 }
        let(:min_maximum_damage) { 4 }
        let(:max_maximum_damage) { 10 }

        let(:name) { 'Grandfather' }
        let(:min_character_level) { 1 }

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has the correct attributes' do
          aggregate_failures do
            expect(subject.name).to eq name
            expect(subject.min_character_level).to eq min_character_level
            expect(subject.min_damage).to be_between(min_minimum_damage, max_minimum_damage)
            expect(subject.max_damage).to be_between(min_maximum_damage, max_maximum_damage)
          end
        end

        describe 'weapon_class' do
          let(:weapon_class) { subject.weapon_class }

          it 'creates an instance of Struct::WeaponClass' do
            expect(weapon_class).to be_instance_of(Struct::WeaponClass)
          end

          it 'has the the expected attributes' do
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
