require 'ostruct'
require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Window do
      it_behaves_like 'Errors'

      subject { described_class.new(map: map, entities: entities) }

      let(:map) { 'home' }
      let(:entities) { [] }

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

      describe '#add_entities' do
        let(:result) { subject.add_entities(new_entities_array) }

        let(:player) { build(:player) }
        let(:npc) { Characters::Npc.new }
        let(:enemy) { Characters::Enemy.new }
        let(:enemy2) { Characters::Enemy.new }
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

          context 'when not all entities are characters or items' do
            let(:new_entities_array) { [invalid_entity, sword, chest, player, npc] }

            it 'is unsuccessful' do
              expect(result.failure?).to eq true
            end

            it 'should have an error message' do
              expect(result.failure.error_messages).to include('InvalidObject base: Could not add entity to Window')
            end
          end

          context 'when none of the entities are characters or items' do
            let(:new_entities_array) { [invalid_entity] }

            it 'is unsuccessful' do
              expect(result.failure?).to eq true
            end

            it 'should have an error message' do
              expect(result.failure.error_messages).to include('InvalidObject base: Could not add entity to Window')
            end
          end
        end
      end
    end
  end
end
