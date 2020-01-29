module Hiro
  module Game
    RSpec.describe Window do
      it_behaves_like 'Errors'

      subject { described_class.new() }

      describe '#initialize' do
        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end
      end
    end
  end
end
