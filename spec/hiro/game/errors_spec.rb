module Hiro
  module Game
    RSpec.shared_examples_for 'Errors' do

      describe '#errors' do
        it 'initializes with no errors' do
          expect(subject.errors).to eq []
        end
      end

      describe '#add_error' do
        let(:msg) { 'Error Message'}
        let(:attribute) { :name }

        it 'adds an error to the object' do
          expect { subject.add_error(msg, attribute) }.to change(subject.errors, :length).by 1
        end

        it 'returns the error' do
          expected_result = Struct::Error.new(subject.class, attribute, msg)
          expect(subject.add_error(msg, attribute)).to eq expected_result
        end

        it 'assigns an attribute' do
          expect(subject.add_error(msg, attribute).attribute).to eq attribute
          subject.add_error(msg, attribute)
        end

        it 'attribute defaults to :base' do
          expect(subject.add_error(msg).attribute).to eq :base
        end

        it 'assigns the object class' do
          expect(subject.add_error(msg, attribute).klass).to eq subject.class
        end
      end

      describe "#valid?" do
        context 'when there are no errors' do
          before { subject.errors = [] }

          it 'returns true' do
            expect(subject.valid?).to eq true
          end
        end

        context 'when there are errors' do
          before { subject.add_error('Error') }

          it 'returns false' do
            expect(subject.valid?).to eq false
          end
        end
      end

      describe "#error_messages" do
        before do
          2.times {|e| subject.add_error("#{e} Error") }
          subject.add_error('Invalid', :name)
        end

        it 'returns an array of messages' do
          expect(subject.error_messages).to eq ['base: 0 Error', 'base: 1 Error', 'name: Invalid']
        end

        context 'when there are no errors' do
          before { subject.errors = [] }

          it 'returns an empty array' do
            expect(subject.error_messages).to eq []
          end
        end
      end
    end
  end
end
