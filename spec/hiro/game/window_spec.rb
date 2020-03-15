require 'ostruct'
require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Window do
      it_behaves_like 'Errors'

      subject { described_class.new(map: map, entities: entities) }

      let(:map) { 'home' }
      let(:entities) { [] }
      let(:player) { build(:player) }
      let(:npc) { Characters::Npc.new }
      let(:enemy) { build(:enemy, x: 2, y: 1) }
      let(:enemy2) { build(:enemy) }
      let(:sword) { build(:sword) }
      let(:chest) { build(:chest) }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.map).to be_instance_of Game::Map
            expect(subject.map.valid?).to eq true
            expect(subject.entities).to eq entities
          end
        end
      end

      describe '#draw' do
        before do
          subject.add_entities([player, enemy])
        end

        it 'draws a window' do
          expect { subject.draw }.not_to raise_error
        end

        describe '#prepare_map_string' do
          let(:expected_map_string) { "*                     \n      O               \n                     \n                     \n                     \n                     \n                     \n                     " }

          it 'returns a map_string' do
            expect(subject.prepare_map_string).to eq expected_map_string
          end
        end
      end

      describe '#add_entities' do
        let(:result) { subject.add_entities(new_entities_array) }

        context 'when all entities are characters or items' do
          let(:new_entities_array) { [sword, player, npc, chest, enemy] }

          it 'is successful' do
            expect(result.success?).to eq true
          end

          it 'adds all entities to the entities array' do
            expect(result.value!).to eq new_entities_array
          end

          context 'and there are already entities' do
            before { subject.entities << enemy2 }
            let(:new_entities_array) { [player, npc, enemy, sword, chest] }

            it 'is successful' do
              expect(result.success?).to eq true
            end

            it 'adds the new entities' do
              expected_result = new_entities_array + [enemy2]
              expect(result.value!).to match_array(expected_result)
            end
          end
        end

        context 'when new_entities is empty' do
          let(:new_entities_array) { [] }

          it 'is successful' do
            expect(result.success?).to eq true
          end

          it 'window entities should not change' do
            expect { result }.not_to change(subject.entities, :length)
          end
        end

        context 'when there is an invalid object' do
          let(:invalid_entity) { Struct.new('InvalidObject') { include Game::Errors; def initialize; super(self); end }.new }
          let(:invalid_class_error_message) { "'Could not add entity (invalid class)' Error on InvalidObject (:base)" }
          let(:duplicate_error_message) { "'Could not add entity (duplicate' Error on Player (:base)" }

          context 'when there is a duplicate entity' do
            let(:new_entities_array) { [player, player] }

            it 'is unsuccessful' do
              expect(result.failure?).to eq true
            end

            it 'returns an error message' do
              expect(result.failure.error_messages).to include(duplicate_error_message)
            end
          end

          context 'when not all entities are characters or items' do
            let(:new_entities_array) { [invalid_entity, sword, chest, player, npc] }

            it 'is unsuccessful' do
              expect(result.failure?).to eq true
            end

            it 'should have an error message' do
              expect(result.failure.error_messages).to include(invalid_class_error_message)
            end
          end

          context 'when none of the entities are characters or items' do
            let(:new_entities_array) { [invalid_entity] }

            it 'is unsuccessful' do
              expect(result.failure?).to eq true
            end

            it 'should have an error message' do
              expect(result.failure.error_messages).to include(invalid_class_error_message)
            end
          end
        end
      end

      describe '#invalid_move?' do
        context 'when the coordinates are valid' do
          let(:coordinates) { { x: 1, y: 1 } }

          it 'returns false' do
            expect(subject.invalid_move?(coordinates)).to eq false
          end
        end

        context 'when the coordinates include a negative' do
          let(:coordinates) { { x: -1, y: 1 } }

          it 'returns true' do
            expect(subject.invalid_move?(coordinates)).to eq true
          end
        end

        context 'when the coordinates don\'t exist' do
          let(:coordinates) { { x: 100, y: 0 } }

          it 'returns true' do
            expect(subject.invalid_move?(coordinates)).to eq true
          end
        end
      end

      describe '#find_overlapping' do
        context 'when two entities have the same coordinates' do
          let(:overlapping_enemy_1) { enemy2 }
          let(:overlapping_enemy_2) { build(:enemy) }

          before { subject.add_entities([player, enemy, overlapping_enemy_1, overlapping_enemy_2]) }

          it 'returns the overlapping entities' do
            expect(subject.find_overlapping(player)).to match_array([overlapping_enemy_1, overlapping_enemy_2])
          end
        end
      end
    end
  end
end
