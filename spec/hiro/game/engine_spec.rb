module Hiro
  module Game
    RSpec.describe Engine do
      subject { described_class.new(options) }

      let(:options) {{}}

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a Window' do
          expect(subject.window).to be_instance_of Game::Window
        end

        it 'initializes a new Player' do
          expect(subject.player).to be_instance_of Characters::Player
        end
      end

      describe 'options' do
        context 'when saved_player is given' do
          let(:options) { { saved_player: saved_player } }
          let(:saved_player) do
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
            expect(subject.player.name).to eq saved_player[:name]
          end
        end
      end

      describe '#draw' do
      end
    end
  end
end
