require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Map do
      it_behaves_like 'Errors'

      subject { described_class.new(map_name: map_name) }

      let(:map_name) { valid_map_name }
      let(:entry_coordinates) { {x: 0, y: 0} }
      let(:exit_coordinates) { {x: 0, y: 0} }
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
      let(:map_name_that_doesnt_exist ) { 'map_name_that_doesnt_exist' }

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

      describe 'failure' do
        context 'when the map name does not exist' do
          let(:map_name) { map_name_that_doesnt_exist }

          it 'is invalid' do
            expect(subject.valid?).to eq false
          end

          it 'adds an error' do
            expect(subject.errors).to include ''
          end
        end
      end
    end
  end
end
