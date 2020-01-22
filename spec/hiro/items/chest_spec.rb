module Hiro
  module Items
    RSpec.describe Chest do
      subject do
        described_class.new(
          armour_class_attributes: armour_class_attributes,
          name: name,
          min_character_level: min_character_level,
        )
      end

      let(:armour_class_attributes) { { type: type, min_defense: min_defense, max_defense: max_defense } }

      describe '#initialize' do
        let(:type) { 'Cloak' }
        let(:min_defense) { 2 }
        let(:max_defense) { 4 }

        let(:name) { "Prince's Purple Jacket" }
        let(:min_character_level) { 1 }

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has the expected attributes' do
          aggregate_failures do
            expect(subject.name).to eq name
            expect(subject.min_character_level). to eq min_character_level
            expect(subject.base_defense).to be_between(min_defense, max_defense)
          end
        end

        describe 'armour_class' do
          let(:armour_class) { subject.armour_class }

          it 'creates an instance of Struct::ArmourClass' do
            expect(armour_class).to be_instance_of(Struct::ArmourClass)
          end

          it 'has the expected attributes' do
            aggregate_failures do
              expect(armour_class.type).to eq type
              expect(armour_class.min_defense).to eq min_defense
              expect(armour_class.max_defense).to eq max_defense
            end
          end
        end
      end
    end
  end
end
