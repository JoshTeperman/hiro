module Hiro
  module Items
    module Weapons
      RSpec.describe Weapon do
        subject { described_class.new(type: type, name: name, attack: attack, equipped: equipped) }

        describe 'sword' do
          let(:type) { Weapons::Sword }
          let(:name) { 'Mountain Smasher' }
          let(:attack) { 3 }
          let(:equipped) { true }

          it 'it has a type' do
            expect(subject.type).to eq type
          end

          it 'is equipped' do
            expect(subject.equipped).to eq true
          end
        end
      end
    end
  end
end
