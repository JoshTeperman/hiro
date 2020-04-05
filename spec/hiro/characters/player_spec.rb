require 'hiro/game/errors_spec'

module Hiro
  module Characters
    RSpec.describe Player do
      it_behaves_like 'Errors'

      subject { described_class.new(player_params) }
      let(:player_params) do
        {
          name: 'Hiro',
          character_level: 88,
          life: 921,
          mana: 1043,
          max_life: 1000,
          max_mana: 1100,
          strength: 64,
          dexterity: 50,
          vitality: 91,
          x: 2,
          y: 8,
          equipped_items: { weapon: nil }
        }
      end

      describe '#initialize' do
        it 'initializes a new player without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a player with the given params' do
          aggregate_failures do
            expect(subject.character_level).to eq(player_params[:character_level])
            expect(subject.name).to eq(player_params[:name])
            expect(subject.life).to eq(player_params[:life])
            expect(subject.mana).to eq(player_params[:mana])
            expect(subject.max_life).to eq(player_params[:max_life])
            expect(subject.max_mana).to eq(player_params[:max_mana])
            expect(subject.strength).to eq(player_params[:strength])
            expect(subject.dexterity).to eq(player_params[:dexterity])
            expect(subject.vitality).to eq(player_params[:vitality])
            expect(subject.x).to eq(player_params[:x])
            expect(subject.y).to eq(player_params[:y])
            expect(subject.equipped_items).to eq(player_params[:equipped_items])
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
