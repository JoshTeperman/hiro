require 'ostruct'

module Hiro
  module Game
    RSpec.describe Window do
      subject { described_class.new(map: map) }

      describe '#initialize' do
        it_behaves_like 'Errors'

        let(:map) { OpenStruct.new(shape: shape, entry_points: entry_points, exit_points: exit_points) }
        let(:entry_points) { [[0, 0]] }
        let(:exit_points) { [[0, 0]] }
        let(:shape) { [[' ', ' '], [' ', ' ']] }

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes' do
          aggregate_failures do
            expect(subject.map.shape).to eq shape
            expect(subject.entities).to eq []
            expect(subject.map.entry_points).to eq entry_points
            expect(subject.map.exit_points).to eq exit_points
          end
        end
      end
    end
  end
end
