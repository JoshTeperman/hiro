module Hiro
  module Game
    RSpec.shared_examples_for 'Errors' do

      describe '@errors' do
        it 'initializes with an empty array' do
          expect(subject.errors).to eq []
        end
      end

      describe '#add_error' do
        msg = 'Error Message'
        attribute = :attribute

        it 'adds an error to the object' do
          expect { subject.add_error(:attribute, msg) }.to change(subject.errors, :length).by 1
        end

        it 'returns the error' do
          expect(subject.add_error(:attribute, msg))
        end

        xit 'is assigned an attribute' do
          expect(subject.add_error(:attribute, msg))
        end

      end
    end
  end
end
