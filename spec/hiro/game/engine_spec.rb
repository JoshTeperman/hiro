module Hiro
  module Game
    RSpec.describe Engine do
      subject { described_class.new }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a global variable window' do
          expect(subject.window).to be_instance_of Game::Window
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
