require 'hiro/game/errors_spec'

module Hiro
  module Characters
    RSpec.describe Enemy do
      subject { described_class.new(enemy_params) }

      let(:enemy_params) do
        {
          x: 0,
          y: 0,
          life: 10,
          level: 1,
          strength: 5,
          dexterity: 5,
          defense: 5
        }
      end

      describe '#initialize' do
        it_behaves_like 'Errors'

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes', aggregate_failures: true do
          expect(subject.x).to eq enemy_params[:x]
          expect(subject.y).to eq enemy_params[:y]
          expect(subject.life).to eq enemy_params[:life]
          expect(subject.level).to eq enemy_params[:level]
          expect(subject.strength).to eq enemy_params[:strength]
          expect(subject.dexterity).to eq enemy_params[:dexterity]
          expect(subject.defense).to eq enemy_params[:defense]
        end
      end
    end
  end
end
