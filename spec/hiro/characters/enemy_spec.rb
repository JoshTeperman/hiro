require 'hiro/game/errors_spec'

module Hiro
  module Characters
    RSpec.describe Enemy do
      subject { described_class.new }

      describe '#initialize' do
        it_behaves_like 'Errors'

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end
      end
    end
  end
end
