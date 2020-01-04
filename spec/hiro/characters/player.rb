module Hiro
  module Characters
    RSpec.describe Player do
      subject do
        described_class.new({
          name: "Test Player",
          attributes: attributes,
          life: 100,
          mana: 10,
          location: 'location'
        })
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
        it 'initializes a new Player' do
          expect { subject }.not_to raise_error
        end

        it 'has the correct Player name' do
          expect(subject.name).to eq('Test Player')
        end

        it 'has the correct default stats' do
          expect(subject.life).to eq(100)
        end
      end
    end
  end
end
