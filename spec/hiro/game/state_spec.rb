require 'hiro/game/errors_spec'

module Hiro
  module Game
    RSpec.describe State do
      it_behaves_like 'Errors'

      subject { described_class.new(state) }

      let(:state) { { window: { map: map, entities: entities } } }
      let(:map) { 'home' }
      let(:entities) { [] }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          expect(subject.window).to eq state.fetch(:window)
        end
      end
    end
  end
end

