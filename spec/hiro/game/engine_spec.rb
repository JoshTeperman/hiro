require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe Engine do
      it_behaves_like 'Errors'

      subject do
        described_class.new(
          player: player_params,
          game_state: game_state_params,
          mode: mode
        )
      end

      let(:player_params) do
        {
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
      end
      let(:game_state_params) { { window: { map: 'home', entities: [] } } }
      let(:mode) { 'normal' }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a Game State', aggregate_failuers: true do
          expect(subject.game_state).to be_instance_of Game::State
          expect(subject.game_state.valid?). to eq true
        end

        it 'initializes a Window', aggregate_failuers: true do
          window = subject.window
          expect(window).to be_instance_of Game::Window
          expect(window.valid?).to eq true
          expect(window.map).to be_instance_of Game::Map
          expect(window.entities).to eq []
        end

        it 'initializes a new Player', aggregate_failuers: true do
          player = subject.player
          expect(player).to be_instance_of Hiro::Characters::Player
          expect(player.valid?).to eq true
          expect(player.attributes).to eq player_params.fetch(:attributes)
        end

        it 'sets the mode' do
          expect(subject.mode).to eq mode
        end
      end

      describe '#valid_game?' do
        it 'returns true' do
          expect(subject.valid_game?).to eq true
        end

        context 'when if @game_state is invalid' do
          before { subject.game_state.add_error('game_state error') }
          it 'returns false' do
            expect(subject.valid_game?).to eq false
          end
        end

        context 'when if @window is invalid' do
          before { subject.window.add_error('window error') }
          it 'returns false' do
            expect(subject.valid_game?).to eq false
          end
        end

        context 'when if @player is invalid' do
          before { subject.player.add_error('player error') }
          it 'returns false' do
            expect(subject.valid_game?).to eq false
          end
        end
      end

      describe '#draw' do
      end

      describe '#run'
    end
  end
end
