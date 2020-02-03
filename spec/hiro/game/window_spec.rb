require 'ostruct'
require 'hiro/game/errors_spec'

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
        let(:result) { subject.add_entities(new_entities_array)}

        let(:player) { build(:player) }
        let(:npc) { Characters::Npc.new }
        let(:enemy) { Characters::Enemy.new }
        let(:sword) { build(:sword) }
        let(:chest) { build(:chest) }

        context 'when all entities are characters or items' do
          let(:new_entities_array) { [sword, player, npc, chest, enemy] }

          it 'is successful' do
            expect(result.success?).to eq true
          end

          it 'adds all entities to the entities array' do
            expect(result.value!).to eq new_entities_array
          end

          context 'and there are already entities' do
            let(:player) { build(:player) }
            let(:npc) { Characters::Npc.new }
            let(:enemy) { Characters::Enemy.new }
            let(:enemy2) { Characters::Enemy.new }
            let(:sword) { build(:sword) }
            let(:chest) { build(:chest) }

            let(:new_entities_array) { [player, npc, enemy, sword, chest] }

            before { subject.entities << enemy2 }

            it 'is successful' do
              expect(result.success?).to eq true
            end

            it 'adds the new entities' do
              expected_result = new_entities_array + [enemy2]
              expect(result.value!).to match_array(expected_result)
            end
          end
        end

        context 'when not all entities are characters or items' do
          let(:new_entities_array) { [] }

          it 'is unsuccessful' do
            expect(result.failure?).to eq true
          end

          it 'returns an Failure monad with Error message' do
          end
        end

        context 'when none of the entities are characters or items' do
          let(:new_entities_array) { [] }

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
