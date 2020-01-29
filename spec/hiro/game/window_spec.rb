module Hiro
  module Game
    RSpec.describe Window do
      it_behaves_like 'Errors'

      subject { described_class.new(map: map) }

      describe '#initialize' do
        let(:map) do
          {
            [[" ", " "], [" ", " "]]

          }
        end
        let(:entry_points) { [[0, 0]] }
        let(:exit_points) { [[0, 0]] }

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.map).to eq map
            expect(subject.entities).to eq entities
            expect(subject.entry_points).to eq entry_points
            expect(subject.exit_points).to eq exit_points
          end
        end
      end
    end
  end
end
