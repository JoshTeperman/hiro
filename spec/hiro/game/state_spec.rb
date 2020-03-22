require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe State do
      it_behaves_like 'Errors'

      subject { described_class.new(state) }

      let(:state) { { current_map: current_map, enemy_data: enemy_data } }
      let(:current_map) { 'home' }
      let(:enemy_data) do
        [
          {
            x: 1,
            y: 0,
            level: 1,
            enemy_class_attributes: {
              type: 'test enemy',
              min_vitality: 1,
              max_vitality: 3,
              min_damage: 1,
              max_damage: 2,
              min_dexterity: 1,
              max_dexterity: 5,
              min_defense: 1,
              max_defense: 5,
            }
          },
          {
            x: 2,
            y: 0,
            level: 1,
            enemy_class_attributes: {
              type: 'test enemy',
              min_vitality: 1,
              max_vitality: 3,
              min_damage: 1,
              max_damage: 2,
              min_dexterity: 1,
              max_dexterity: 5,
              min_defense: 1,
              max_defense: 5,
            }
          }
        ]
      end

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes', aggregate_failures: true do
          expect(subject.current_map).to eq current_map
          expect(subject.enemies.length).to eq 2
        end

        it 'instantiates Character::Enemy classes from the enemy_data' do
          expect(subject.enemies).to all(be_a(Characters::Enemy))
        end
      end
    end
  end
end
