module Hiro
  module Items
    module Weapons
      RSpec.describe Sword do
        subject { described_class.new }

        let(:range) { 1 }

        it 'has a range of 1' do
          expect(subject.range).to eq range
        end
      end
    end
  end
end
