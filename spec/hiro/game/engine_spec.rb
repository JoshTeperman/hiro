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
          x: 3,
          y: 3,
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
        it 'add_entities to window' do
          subject.draw
          expected_entities = [subject.player, *subject.enemies]
          expect(subject.window.entities).to match_array(expected_entities)
        end

        it 'calls window#draw' do
          engine = instance_spy('Engine')
          engine.draw
          expect(engine.window).to have_received(:draw).with(no_args)
        end
      end

      describe '#try_move' do
        let(:move) { subject.try_move(direction) }

        context 'when direction is up' do
          let(:direction) { :up }
          it 'increments @y coordinate by -1' do
            expect { move }.to change(subject.player, :y).by(-1)
          end
        end

        context 'when direction is down' do
          let(:direction) { :down }
          it 'increments @y coordinate by 1' do
            expect { move }.to change(subject.player, :y).by(1)
          end
        end

        context 'when direction is left' do
          let(:direction) { :left }
          it 'increments @x coordinate by -1' do
            expect { move }.to change(subject.player, :x).by(-1)
          end
        end

        context 'when direction is right' do
          let(:direction) { :right }
          it 'increments @x coordinate by 1' do
            expect { move }.to change(subject.player, :x).by(1)
          end
        end

        context 'when the move is invalid' do
          let(:direction) { :right }
          before { allow(subject.window).to receive(:invalid_move?).and_return(true) }

          it 'does nothing' do
            expect { move }.not_to change(subject.player, :x)
          end
        end
      end

      describe '#combat' do
      end
    end
  end
end
