require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Engine do
      it_behaves_like 'Errors'

      subject { described_class.new(player: player_params, game_state: game_state, mode: mode) }

      let(:player_params) { {} }
      let(:game_state) { {} }
      let(:mode) { nil }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        describe 'defaults' do
          it 'initializes a default Game State', aggregate_failuers: true do
            game_state = subject.game_state
            expect(game_state).to be_instance_of Game::State
          end

          it 'initializes a default Window', aggregate_failuers: true do
            window = subject.window
            default_shape = [
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil]
            ]
            expect(window).to be_instance_of Game::Window
            expect(window.map.shape).to eq default_shape
          end

          it 'initializes a new Player', aggregate_failuers: true do
            player = subject.player
            default_player_attributes = {
              name: 'Hiro',
              life: 10,
              mana: 10,
              character_level: 1,
              x: 0,
              y: 0,
              attributes: {
                max_life: 5,
                max_mana: 5,
                strength: 5,
                dexterity: 5,
                vitality: 5,
                intelligence: 5
              }
            }
            expect(player).to be_instance_of Characters::Player
            expect(player.attributes).to eq default_player_attributes
          end
        end
      end

      context 'when saved_player is given' do
        let(:player_params) do
          {
            name: 'Saved Player',
            life: 20,
            mana: 50,
            character_level: 4,
            location: Game::Locations::HOME,
            attributes: {
              max_life: 55,
              max_mana: 56,
              strength: 13,
              dexterity: 99,
              vitality: 86,
              intelligence: 11,
            },
          }
        end

        it 'loads the saved player' do
          expect(subject.player.name).to eq player_params[:name]
        end
      end

      describe '#draw' do
      end
    end
  end
end
