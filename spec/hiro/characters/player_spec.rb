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
        before do
          subject.equipped_gear = equipped_gear
          subject.switch_gear = switch_gear
        end

        context 'when equipped_items is empty' do
          let(:equipped_gear) { {} }

          context 'and all of the items level requirements are equal to or below the character level' do
            let(:character_level) { 1 }
            let(:weapon) { instance_double(Items::Sword, min_character_level: 1) }
            let(:params) { { weapon: weapon } }

            it 'is successful' do
              expect(subject.equip(params).success?).to eq true
            end

            it 'equips the items' do
              expect(subject.equip(params)).to change { subject.equipped_gear.weapon }.from(nil).to(weapon)
            end

            it 'records which items were equipped' do
              expect(subject.equip(params).equipped).to eq weapon
            end
          end

          context 'and some of the items level requirements are equal to or below the character level' do
            it 'equips all equippable items'
          end

          context 'and none of the items level requirements are equal to or below the character level' do
            it 'equips none of the items'
          end

          context 'when equipping an item to an equipped slot' do
            it 'updates equipped items'
          end
        end

        context 'when equipped_items is not empty' do
        end

        context 'when switch_gear is empty' do
          let(:switch_gear) { {} }
        end

        context 'when switch_gear is not empty' do
        end
      end
    end

    describe '#equipped_gear' do
      let(:equipped_gear) { { weapon: weapon} }
      let(:weapon) { instance_double(Items::Sword) }

      before { subject.equipped_gear = equipped_gear }

      it 'returns all the player\'s equipped equipped_gear' do
        expect(subject.equipped_gear).to eq(equipped_gear)
      end
    end
  end
end
