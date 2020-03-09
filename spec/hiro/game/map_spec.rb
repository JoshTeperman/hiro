require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Map do
      it_behaves_like 'Errors'

      subject { described_class.new(map_name: map_name) }

      let(:map_name) { valid_map_name }
      let(:entry_coordinates) { { x: 0, y: 0 } }
      let(:exit_coordinates) { { x: 0, y: 0 } }
      let(:shape) do
        [
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        ]


      end

      let(:valid_map_name) { 'home' }
      let(:map_name_that_doesnt_exist ) { 'map_name_that_doesnt_exist' }

      describe '#initialize', aggregate_failures: true do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          expect(subject.name).to eq map_name
          expect(subject.entry_coordinates).to eq entry_coordinates
          expect(subject.exit_coordinates).to eq exit_coordinates
          expect(subject.shape).to eq shape
        end
      end

      describe 'failure' do
        context 'when the map name does not exist' do
          let(:map_name) { map_name_that_doesnt_exist }

          it 'is invalid but does not raise error' do
            aggregate_failures do
              expect(subject.valid?).to eq false
              expect { subject }.not_to raise_error
            end
          end

          it 'adds an error' do
            expected_error_message = "'Error loading map data: File 'map_name_that_doesnt_exist.yml' not found at path lib/hiro/game/data/maps/map_name_that_doesnt_exist' Error on Map (:data)"
            expect(subject.error_messages).to include expected_error_message
          end

          it 'should initialize a map with nil attributes' do
            aggregate_failures do
              expect(subject.entry_coordinates).to be_nil
              expect(subject.exit_coordinates).to be_nil
              expect(subject.shape).to be_nil
            end
          end
        end
      end
    end
  end
end
