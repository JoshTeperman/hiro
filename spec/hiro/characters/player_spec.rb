module Hiro
  module Characters
    RSpec.describe Player do
      subject do
        described_class.new(
          name: 'Hiro',
          attributes: attributes,
          life: 100,
          mana: 10,
          location: 'location'
        )
      end

      let(:attributes) do
        {
          max_life: 100,
          max_mana: 10,
          strength: 5,
          dexterity: 5,
          vitality: 5,
          intelligence: 5,
          inventory_space: 5,
        }
      end

      describe '#initialize' do
        it 'initializes a new Player without error' do
          expect { subject }.not_to raise_error
        end

        it 'has a name' do
          expect(subject.name).to eq('Hiro')
        end

        it 'has default attributes' do
          expect(subject.attributes).to eq(attributes)
        end
      end
    end
  end
end
