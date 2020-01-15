module Hiro
  module Characters
    RSpec.describe Player do
      subject do
        described_class.new(
          name: 'Hiro',
          attributes: attributes,
          life: 100,
          mana: 10,
          location: 'location'
        )
      end

      let(:attributes) do
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

      describe '#initialize' do
        it 'initializes a new Player without error' do
          expect { subject }.not_to raise_error
        end

        it 'has a name' do
          expect(subject.name).to eq('Hiro')
        end

        it 'has default attributes' do
          expect(subject.attributes).to eq(attributes)
        end
      end

      describe '#equipped_weapon' do
        context 'when the player has a weapon equipped' do
          let(:equipped_weapon) { instance_double(Items::Sword) }

          before { subject.equipped_weapon = equipped_weapon }

          it 'returns the equipped weapon' do
            expect(subject.equipped_weapon).to eq(equipped_weapon)
          end
        end

        context 'when the player has no weapon equipped' do
          let(:equipped_weapon) { nil }

          it 'returns nil' do
            expect(subject.equipped_weapon).to be_nil
          end
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
          let(:equipped_gear) { {} }
          let(:params) { { weapon: weapon } }

          context 'and all of the items level requirements are equal to or below the character level' do
            it 'equips all items' do
            end
          end

          context 'and some of the items level requirements are equal to or below the character level' do
            it 'equips all equippable items' do
            end
          end

          context 'and none of the items level requirements are equal to or below the character level' do
            it 'equips none of the items' do
            end
          end

          context 'when equipping an item to an equipped slot' do
            it 'updates equipped items' do
            end
          end
        end
      end
    end
  end
end
