require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe State do
      it_behaves_like 'Errors'

      subject { described_class.new(game_state) }

      let(:game_state) { { window: { map: map, entities: entities } } }
      let(:map) { 'home' }
      let(:entities) { [] }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          expect(subject.window).to eq game_state.fetch(:window)
        end
      end
    end
  end
end

