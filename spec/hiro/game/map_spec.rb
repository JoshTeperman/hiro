require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Map do
      it_behaves_like 'Errors'

      subject { described_class.new(map_params) }

      let(:map_params) do
        {
          shape: shape,
          entry_coordinates: entry_coordinates,
          exit_coordinates: exit_coordinates,
        }
      end

      let(:entry_coordinates) { [0, 0] }
      let(:exit_coordinates) { [0, 0] }
      let(:shape) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      describe '#initialize', aggregate_failures: true do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          expect(subject.entry_coordinates).to eq entry_coordinates
          expect(subject.exit_coordinates).to eq exit_coordinates
          expect(subject.shape).to eq shape
        end
      end
    end
  end
end
