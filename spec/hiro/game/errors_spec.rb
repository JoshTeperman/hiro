module Hiro
  module Game
    RSpec.shared_examples_for 'Errors' do
      it 'has an error object' do
        expect(subject.errors).to eq []
      end
    end
  end
end
