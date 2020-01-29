module Hiro
  module Game
    RSpec.describe Engine do
      subject { described_class.new }

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


      describe '#input' do
      end

      describe '#update' do
      end

      describe '#draw' do
      end
    end
  end
end
