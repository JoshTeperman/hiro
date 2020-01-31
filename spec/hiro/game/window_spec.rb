require 'ostruct'

module Hiro
  module Game
    RSpec.describe Window do
      it_behaves_like 'Errors'

      subject { described_class.new(map: map) }

      let(:map) { OpenStruct.new(shape: shape, entry_points: entry_points, exit_points: exit_points) }
      let(:entry_points) { [[0, 0]] }
      let(:exit_points) { [[0, 0]] }
      let(:shape) { [[' ', ' '], [' ', ' ']] }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.map.shape).to eq shape
            expect(subject.entities).to eq []
            expect(subject.map.entry_points).to eq entry_points
            expect(subject.map.exit_points).to eq exit_points
          end
        end
      end

      describe '#add_entity' do
        let(:entity) { instance_double(Characters::Player) }

        it 'adds an entity to the entities array' do
          expect { subject.add_entity(entity) }.to change(subject.entities, :length).by(1)
        end

        it 'returns the entity array' do
          expect(subject.add_entity(entity).value!).to eq([entity])
        end
      end
    end
  end
end
