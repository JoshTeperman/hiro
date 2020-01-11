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

      it 'has a min_level' do
        expect(subject.min_level).to eq min_level
      end

      it 'has base damage' do
        expect(subject.base_damage).to eq base_damage
      end
    end
  end
end
