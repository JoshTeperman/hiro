module Hiro
  module Items
    RSpec.describe Weapon do
      subject do
        described_class.new(
          weapon_class_attributes: weapon_class_attributes,
          name: name,
          min_character_level: min_character_level,
          range: range,
        )
      end

      let(:weapon_class_attributes) { { type: type, min_damage: min_damage, max_damage: max_damage, max_base_damage: max_base_damage } }

      describe '#initialize' do
        let(:type) { 'Long Sword' }
        let(:min_damage) { 2 }
        let(:max_damage) { 10 }
        let(:max_base_damage) { 4 }

        let(:name) { 'Godfather' }
        let(:min_character_level) { 25 }
        let(:range) { 2 }

        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.name).to eq name
            expect(subject.min_character_level).to eq min_character_level
            expect(subject.range).to eq range
            expect(subject.base_damage).to be_between(min_damage, max_base_damage)
          end
        end

        context 'when it has no name' do
          let(:name) { nil }

          it 'it is a weapon without a name' do
            expect(subject.name).to be_nil
          end
        end

        describe 'weapon_class' do
          let(:weapon_class) { subject.weapon_class }

          it 'creates an instance of Struct::WeaponClass with the expected attributes' do
            aggregate_failures do
              expect(weapon_class).to be_instance_of(Struct::WeaponClass)
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
end
