module Hiro
  module Items
    RSpec.describe Armour do
      subject do
        described_class.new(
          armour_class_attributes: armour_class_attributes,
          name: name,
          min_character_level: min_character_level,
        )
      end

      let(:armour_class_attributes) do
        {
          type: type,
          min_defense: min_defense,
          max_defense: max_defense,
          max_base_defense: max_base_defense,
        }
      end

      describe `#initialize` do
        let(:type) { 'Cloak' }
        let(:min_defense) { 2 }
        let(:max_defense) { 6 }
        let(:max_base_defense) { 3 }

        let(:name) { "Prince's Jacket" }
        let(:min_character_level) { 1 }

        it 'has expected_attributes' do
          expect(subject.name).to eq name
          expect(subject.min_character_level).to eq min_character_level
        end

        context 'when it has no name' do
          let(:name) { nil }

          it 'is armour without name' do
            expect(subject.name).to be_nil
          end
        end

        describe 'armour_class' do
          let(:armour_class) { subject.armour_class }

          it 'creates an instance of Struct::ArmourClass with the expected attributes' do
          end
        end
      end
    end
  end
end
