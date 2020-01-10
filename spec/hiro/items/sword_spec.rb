module Hiro
  module Items
    RSpec.describe Sword do
      subject { described_class.new(params) }

      let(:params) do
        {
          name: name,
          min_level: min_level,
          base_damage: base_damage,
        }
      end

      let(:name) { 'Sword' }
      let(:min_level) { 1 }
      let(:base_damage) { 2 }

      it 'has a range of 1' do
        expect(subject.range).to eq range
      end
    end
  end
end
