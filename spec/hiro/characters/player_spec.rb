require 'hiro/game/errors_spec'

module Hiro
  module Characters
    RSpec.describe Player do
      it_behaves_like 'Errors'

      subject { described_class.new(player_params) }
      let(:player_params) do
        {
          name: 'Hiro',
          life: 921,
          mana: 1043,
          character_level: 88,
          x: 2,
          y: 8,
          attributes: {
            max_life: 1000,
            max_mana: 1100,
            strength: 64,
            dexterity: 50,
            vitality: 91,
            intelligence: 45,
          },
        }
      end

      describe '#initialize' do
        it 'initializes a new player without error' do
          expect { subject }.not_to raise_error
        end

        it 'initializes a player with the given params' do
          aggregate_failures do
            expect(subject.name).to eq(player_params[:name])
            expect(subject.life).to eq(player_params[:life])
            expect(subject.mana).to eq(player_params[:mana])
            expect(subject.character_level).to eq(player_params[:character_level])
            expect(subject.x).to eq(player_params[:x])
            expect(subject.y).to eq(player_params[:y])
            expect(subject.attributes).to eq(player_params[:attributes])
          end
        end

        context 'when no player_params are given' do
          let(:player_params) { nil }

          it 'initializes a new Player without error' do
            expect { subject }.not_to raise_error
          end

          it 'initializes a new player with default attributes' do
            defaults = {
              name: 'Hiro',
              life: 10,
              mana: 10,
              character_level: 1,
              x: 0,
              y: 0,
              attributes: {
                max_life: 5,
                max_mana: 5,
                strength: 5,
                dexterity: 5,
                vitality: 5,
                intelligence: 5,
              },
            }

            aggregate_failures do
              expect(subject.name).to eq(defaults[:name])
              expect(subject.life).to eq(defaults[:life])
              expect(subject.mana).to eq(defaults[:mana])
              expect(subject.character_level).to eq(defaults[:character_level])
              expect(subject.x).to eq(defaults[:x])
              expect(subject.y).to eq(defaults[:y])
              expect(subject.attributes).to eq(defaults[:attributes])
            end
          end
        end
      end

      describe '#equip' do
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
              let(:chest) { instance_double(Items::Chest, min_character_level: 1) }

              it 'equips the new item' do
                expect { subject.equip(chest: chest) }.to change { subject.equipped_gear.count }.by(1)
              end

              it 'returns the updated equipped_gear object' do
                expect(subject.equip(chest: chest).value!).to eq(chest: chest, weapon: weapon)
              end
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

      describe 'movement' do
        describe '#move_up' do
          it 'increments @y coordinate by 1' do
            expect { subject.move_up }.to change(subject, :y).by(1)
          end
        end

        describe '#move_down' do
          it 'increments @y coordinate by negative 1' do
            expect { subject.move_down }.to change(subject, :y).by(-1)
          end
        end

        describe '#move_right' do
          it 'increments @x coordinate by 1' do
            expect { subject.move_right }.to change(subject, :x).by(1)
          end
        end

        describe '#move_left' do
          it 'increments @x coordinate by negative 1' do
            expect { subject.move_left }.to change(subject, :x).by(-1)
          end
        end

        describe '#valid_move?' do
        end

        describe '#adjacent?' do
        end
      end
    end
  end
end
