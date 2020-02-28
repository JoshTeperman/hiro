require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Engine do
      it_behaves_like 'Errors'

      subject { described_class.new(player: player_params, game_state: game_state, mode: mode) }

      let(:player_params) do
        {
          player: {
            name: 'Saved Player',
            life: 20,
            mana: 30,
            character_level: 4,
            x: 0,
            y: 0,
            attributes: {
              max_life: 55,
              max_mana: 56,
              strength: 13,
              dexterity: 99,
              vitality: 86,
              intelligence: 11,
            }
          }
        }
      end
      let(:game_state) { { map: 'home', entities: [] } }
      let(:mode) { 'normal' }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a Game State', aggregate_failuers: true do
          expect(subject.game_state).to be_instance_of Game::State
          expect(subject.game_state.map).to eq game_state[:map]
        end

        it 'initializes a Window', aggregate_failuers: true do
          window = subject.window
          expect(window).to be_instance_of Game::Window
          expect(window.map).to_be_instance_of Game::Map
          expect(window.entities).to eq map[:entities]
        end

        it 'initializes a new Player', aggregate_failuers: true do
          player = subject.player
          expect(player).to_be_instance_of Game::Characters::Player
          expect(player.attributes).to eq player_params[:attributes]
        end
      end

      describe '#draw' do
      end
    end
  end
end
