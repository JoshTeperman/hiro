require 'hiro/game/errors_spec'

module Hiro
  module Characters
    RSpec.describe Player do
      it_behaves_like 'Errors'

      subject do described_class.new(
        name: name,
        character_level: character_level,
        life: life,
        mana: mana,
        max_life: max_life,
        max_mana: max_mana,
        strength: strength,
        dexterity: dexterity,
        vitality: vitality,
        x: x,
        y: y,
        equipped_items: equipped_items
      )
      end

      let(:name) { 'Hiro' }
      let(:character_level) { 88 }
      let(:life) { 921 }
      let(:mana) { 1043 }
      let(:max_life) { 1000 }
      let(:max_mana) { 1100 }
      let(:strength) { 64 }
      let(:dexterity) { 50 }
      let(:vitality) { 91 }
      let(:x) { 2 }
      let(:y) { 8 }
      let(:equipped_items) { { weapon: nil } }

      describe '#initialize' do
        it 'initializes a new player without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a player with the given params' do
          aggregate_failures do
            expect(subject.character_level).to eq(character_level)
            expect(subject.name).to eq(name)
            expect(subject.life).to eq(life)
            expect(subject.mana).to eq(mana)
            expect(subject.max_life).to eq(max_life)
            expect(subject.max_mana).to eq(max_mana)
            expect(subject.strength).to eq(strength)
            expect(subject.dexterity).to eq(dexterity)
            expect(subject.vitality).to eq(vitality)
            expect(subject.x).to eq(x)
            expect(subject.y).to eq(y)
            expect(subject.equipped_items).to eq(equipped_items)
          end
        end

        context 'when life is not given' do
          let(:life) { nil }

          it 'sets life to max_life' do
            expect(subject.life).to eq max_life
          end
        end
      end

      describe '#equip' do
        let(:weapon) { instance_double(Items::Sword, min_character_level: 1) }
        before do
          subject.equipped_items = equipped_items
        end

        describe 'success' do
          context 'when equipped_items is empty' do
            let(:equipped_items) { {} }

            it 'is successful' do
              expect(subject.equip(weapon: weapon).success?).to eq true
            end

            it 'equips the item' do
              expect { subject.equip(weapon: weapon) }.to change { subject.equipped_items[:weapon] }.from(nil).to(weapon)
            end

            it 'returns the updated equipped_items object' do
              expect(subject.equip(weapon: weapon).value!).to eq(weapon: weapon)
            end
          end

          context 'when equipped_items is not empty' do
            let(:equipped_items) { { weapon: weapon } }

            context 'when there is an item already equipped of the same type' do
              let(:weapon_2) { instance_double(Items::Sword, min_character_level: 1) }

              it 'replaces the item' do
                expect { subject.equip(weapon: weapon_2) }.to change { subject.equipped_items[:weapon] }.from(weapon).to(weapon_2)
              end
            end

            context 'when there is an item already equipped of a different type' do
              let(:chest) { instance_double(Items::Chest, min_character_level: 1) }

              it 'equips the new item' do
                expect { subject.equip(chest: chest) }.to change { subject.equipped_items.count }.by(1)
              end

              it 'returns the updated equipped_items object' do
                expect(subject.equip(chest: chest).value!).to eq(chest: chest, weapon: weapon)
              end
            end
          end
        end

        describe 'failure' do
          context 'when the item is already equipped' do
            let(:equipped_items) { { weapon: weapon } }
            let(:result) { subject.equip(weapon: weapon) }

            it 'adds an error' do
              expect(result.failure[:errors]).to include('Weapon: Item is already equipped')
            end

            it 'fails to equip the item' do
              expect { result }.not_to(change { subject.equipped_items })
            end
          end

          context 'when the the item level requirements are above the character level' do
            let(:weapon) { instance_double(Items::Sword, min_character_level: 100 ) }
            let(:equipped_items) { { weapon: weapon } }
            let(:result) { subject.equip(weapon: weapon) }

            it 'adds an error' do
              expect(result.failure[:errors]).to include('Weapon: You do not meet the level requirements for this item')
            end

            it 'fails to equip the item' do
              expect { result }.not_to(change { subject.equipped_items })
            end
          end
        end
      end

      describe '#equipped_items' do
        let(:equipped_items) { { weapon: weapon} }
        let(:weapon) { instance_double(Items::Sword) }

        before { subject.equipped_items = equipped_items }

        it 'returns all the player\'s equipped_items' do
          expect(subject.equipped_items).to eq(equipped_items)
        end
      end

      describe '#move' do
        let(:coordinates) { { x: 2, y: 3 } }
        before { subject.move(coordinates) }

        it 'updates the player x and y coordinates', aggregate_failures: true do
          expect(subject.x).to eq 2
          expect(subject.y).to eq 3
        end
      end
    end
  end
end
