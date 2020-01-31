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

      describe '#add_entities' do
        let(:result) { subject.add_entities(entities_array)}

        let(:player_entity) { instance_double(Characters::Player) }
        let(:weapon_entity) { instance_double(Items::Sword) }
        let(:armour_entity) { instance_double(Items::Chest) }
        # let(:npc_entity) { instance_double(Character::Npc) }

        context 'when all entities are characters, NPCs or items' do
          let(:entities_array) { [] }

          it 'is successful' do
            expect(result.success?).to eq true
          end

          it 'adds all entities to the entities array' do
            expect(result.value!).to eq entities_array
          end
        end

        context 'when not all entities are characters, NPCs, or items' do
          let(:entities_array) { [] }

          it 'is unsuccessful' do
            expect(result.failure?).to eq true
          end

          it 'returns an Failure monad with Error message' do
          end
        end

        context 'when none of the entities are characterse, NPCs, or items' do
          let(:entities_array) { [] }

          it 'is unsuccessful' do
            expect(result.failure?).to eq true
          end

          it 'returns an Failure monad with Error message' do
          end
        end
      end
    end
  end
end
