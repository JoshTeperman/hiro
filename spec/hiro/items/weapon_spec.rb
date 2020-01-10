module Hiro
  module Items
    RSpec.describe Weapon do
      subject { described_class.new(params) }

      let(:params) do
        {
          name: name,
          min_level: min_level,
          base_damage: base_damage,
        }
      end

      let(:name) { 'Weapon' }
      let(:min_level) { 1 }
      let(:base_damage) { 2 }
      let(:range) { 1 }


      describe '#initialize' do
        it 'has a name' do
          expect(subject.name).to eq name
        end

        it 'has a min_level' do
          expect(subject.min_level).to eq min_level
        end

        it 'has base damage' do
          expect(subject.base_damage).to eq base_damage
        end

        it 'has a range of 1' do
          expect(subject.range).to eq range
        end
      end

      describe '#set_base_damage' do
      end

      describe '#calculate_modified_damage' do
        # TODO: Calculate on top of base damage
      end

      describe '#equip' do
      end

      describe '#unequip' do
      end

      describe '#drop' do
      end
    end
  end
end
