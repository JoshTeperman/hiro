module Hiro
  module Items
    RSpec.describe Sword do
      subject { described_class.new(params) }

      let(:params) do
        {
          weapon_class: weapon_class,
          name: name,
          min_character_level: min_character_level,
          base_damage: base_damage,
          range: range
        }
      end

      let(:weapon_class) { instance_double(Sword, type: 'Long Sword', min_damage: 2, max_damage: 10, max_base_damage: 4) }
      let(:name) { 'Sword Name' }
      let(:min_character_level) { 1 }
      let(:base_damage) { 2 }
      let(:range) { 2 }

      it 'has the correct attributes' do
        aggregate_failures do
          expect(subject.name).to eq name
          expect(subject.min_character_level).to eq min_character_level
          expect(subject.base_damage).to eq base_damage
          expect(subject.range).to eq range
        end
      end

      context 'when no range is given' do
        let(:params) do
          {
            name: name,
            min_character_level: min_character_level,
            base_damage: base_damage,
          }
        end

        it 'has a default range of 1' do
          expect(subject.range).to eq 1
        end
      end
    end
  end
end
