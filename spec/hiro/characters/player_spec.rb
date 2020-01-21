module Hiro
  module Characters

    RSpec.describe Player do
      subject do
        described_class.new(
          name: name,
          attributes: default_attributes,
          character_level: character_level,
          life: life,
          mana: mana,
          location: location,
        )
      end

      let(:default_attributes) do
        {
          max_life: 100,
          max_mana: 10,
          strength: 5,
          dexterity: 5,
          vitality: 5,
          intelligence: 5,
          inventory_space: 5,
        }
      end

      let(:life) { 100 }
      let(:mana) { 5 }
      let(:name) { 'Hiro' }
      let(:character_level) { 1 }
      let(:location) { 'location' }

      describe '#initialize' do
        it 'initializes a new Player without error' do
          expect { subject }.not_to raise_error
        end

        it 'has default attributes' do
          aggregate_failures do
            expect(subject.attributes).to eq(default_attributes)
            expect(subject.life).to eq(life)
            expect(subject.mana).to eq(mana)
            expect(subject.character_level).to eq(character_level)
            expect(subject.location).to eq(location)
            expect(subject.name).to eq(name)
          end
        end
      end

      describe '#equip' do
        let(:character_level) { 1 }
        let(:weapon) { instance_double(Items::Sword, min_character_level: 1) }

        before do
          subject.equipped_gear = equipped_gear
        end

        describe 'success' do
          context 'when equipped_gear is empty' do
            let(:equipped_gear) { {} }

            it 'is successful' do
              expect(subject.equip(weapon: weapon).success?).to eq true
            end

            it 'equips the item' do
              expect { subject.equip(weapon: weapon) }.to change { subject.equipped_gear[:weapon] }.from(nil).to(weapon)
            end

            it 'returns the updated equipped_gear object' do
              expect(subject.equip(weapon: weapon).value!).to eq(weapon: weapon)
            end
          end

          context 'when equipped_gear is not empty' do
            let(:equipped_gear) { { weapon: weapon } }

            context 'when there is an item already equipped of the same type' do
              let(:weapon_2) { instance_double(Items::Sword, min_character_level: 1) }

              it 'replaces the item' do
                expect { subject.equip(weapon: weapon_2) }.to change { subject.equipped_gear[:weapon] }.from(weapon).to(weapon_2)
              end
            end

            context 'when there is an item already equipped of a different type' do
              # TODO: 'equips the new item'
            end
          end
        end

        describe 'failure' do
          context 'when the item is already equipped' do
            let(:equipped_gear) { { weapon: weapon } }
            let(:result) { subject.equip(weapon: weapon) }

            it 'adds an error' do
              expect(result.failure[:errors]).to include('Weapon: Item is already equipped')
            end

            it 'fails to equip the item' do
              expect { result }.not_to(change { subject.equipped_gear })
            end
          end

          context 'when the the item level requirements are above the character level' do
            let(:weapon) { instance_double(Items::Sword, min_character_level: 100 ) }
            let(:equipped_gear) { { weapon: weapon } }
            let(:result) { subject.equip(weapon: weapon) }

            it 'adds an error' do
              expect(result.failure[:errors]).to include('Weapon: You do not meet the level requirements for this item')
            end

            it 'fails to equip the item' do
              expect { result }.not_to(change { subject.equipped_gear })
            end
          end
        end
      end

      describe '#equipped_gear' do
        let(:equipped_gear) { { weapon: weapon} }
        let(:weapon) { instance_double(Items::Sword) }

        before { subject.equipped_gear = equipped_gear }

        it 'returns all the player\'s equipped_gear' do
          expect(subject.equipped_gear).to eq(equipped_gear)
        end
      end
    end
  end
end
