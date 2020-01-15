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
            expect(subject.level).to eq(level)
            expect(subject.location).to eq(location)
            expect(subject.name).to eq(name)
          end
        end
      end

      describe '#gear' do
        let(:gear) { { weapon: weapon} }
        let(:weapon) { instance_double(Items::Sword) }

        before { subject.gear = gear }

        it 'returns all the player\'s equipped gear' do
          expect(subject.gear).to eq(gear)
        end
      end

      describe '#equip' do
        let(:weapon) { instance_double(Items::Sword) }

        # TODO create classes:
        # let(:chest) { instance_double(Items::Chest) }
        # let(:head) { instance_double(Items::Head) }
        # let(:gloves) { instance_double(Items::Gloves) }
        # let(:boots) { instance_double(Items::Boots) }
        # let(:belt) { instance_double(Items::Belt)}
        # let(:ring) { instance_double(Items::Ring) }
        # let(:necklace) { instance_double(Items::Necklace) }
        # let(:orb) { instance_double(Items::Orb) }

        context 'when there are no equipped items' do
          let(:gear) { {} }

          context 'and all of the items level requirements are equal to or below the character level' do
            let(:character_level) { 1 }
            let(:weapon) { instance_double(Items::Sword, min_character_level: 1) }
            let(:params) { { weapon: weapon } }

            it 'is successful' do
              expect(subject.equip(params).success?).to eq true
            end

            it 'equips the items' do
              expect(subject.equip(params)).to change { subject.gear.weapon }.from(nil).to(weapon)
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
      end

      describe '#gear' do
        let(:gear) { { weapon: weapon} }
        let(:weapon) { instance_double(Items::Sword) }

        before { subject.gear = gear }

        it 'returns all the player\'s equipped gear' do
          expect(subject.gear).to eq(gear)
        end
      end
    end
  end
end
