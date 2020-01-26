module Hiro
  module Game
    RSpec.shared_examples_for 'Errors' do

      describe '@errors' do
        it 'initializes with an empty array' do
          expect(subject.errors).to eq []
        end
      end

      describe '#add' do
      end
    end
  end
end
