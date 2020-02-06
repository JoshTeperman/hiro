require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Map do
      it_behaves_like 'Errors'

      subject { described_class.new(map_name: map_name) }

      let(:map_name) { valid_map_name }
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

      let(:valid_map_name) { 'home' }
      let(:invalid_map_name) { 'invalid_map_name' }

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
