require 'hiro/game/errors_spec'

module Hiro
  module Characters
    RSpec.describe Enemy do
      subject { described_class.new(enemy_params) }

      let(:enemy_params) do
        {
          x: 0,
          y: 0,
          name: name,
          enemy_class_attributes: enemy_class_attributes,
          weapon_attributes: enemy_weapon_attributes,
          level: 1
        }
      end

      let(:name) { 'COVID-19' }
      let(:enemy_class_attributes) do
        {
          type: type,
          min_vitality: min_vitality,
          max_vitality: max_vitality,
          min_dexterity: min_dexterity,
          max_dexterity: max_dexterity,
          min_defense: min_defense,
          max_defense: max_defense,
        }
      end

      let(:type) { 'Monster' }
      let(:min_vitality) { 1 }
      let(:max_vitality) { 5 }
      let(:min_dexterity) { 1 }
      let(:max_dexterity) { 5 }
      let(:min_defense) { 1 }
      let(:max_defense) { 10 }
      let(:enemy_weapon_attributes) do
        {
          name: 'Enemy Sword',
          min_damage: 1,
          max_damage: 5,
          range: 1
        }
      end

      describe '#initialize' do
        it_behaves_like 'Errors'

        it 'initializes without error' do
          expect { subject }.not_to raise_error
        end

        it 'has expected attributes', aggregate_failures: true do
          expect(subject.x).to eq enemy_params[:x]
          expect(subject.y).to eq enemy_params[:y]
          expect(subject.name).to eq enemy_params[:name]
          expect(subject.enemy_class).to be_instance_of Struct::EnemyClass
          expect(subject.weapon).to be_instance_of Struct::Weapon
          expect(subject.level).to eq enemy_params[:level]
          expect(subject.life).to eq subject.max_life
          expect(subject.dexterity).to be_between(min_dexterity, max_dexterity)
          expect(subject.defense).to be_between(min_defense, max_defense)
        end

        context 'when there is no name' do
          let(:name) { nil }

          it 'returns the enemy class type' do
            expect(subject.name).to eq type
          end
        end

        describe 'Weapon Struct' do
          let(:weapon) { subject.weapon }
          it 'instantiates an instance of Struct::Weapon', aggregate_failures: true do
            expect(weapon.name).to eq enemy_weapon_attributes[:name]
            expect(weapon.range).to eq enemy_weapon_attributes[:range]
            expect(weapon.min_damage).to eq enemy_weapon_attributes[:min_damage]
            expect(weapon.max_damage).to eq enemy_weapon_attributes[:max_damage]
          end
        end

        describe 'EnemyClass Struct' do
          let(:enemy_class) { subject.enemy_class }
          it 'instantiates an instance of Struct::EnemyClass', aggregate_failures: true do
            expect(enemy_class.min_vitality).to eq min_vitality
            expect(enemy_class.max_vitality).to eq max_vitality
            expect(enemy_class.min_dexterity).to eq min_dexterity
            expect(enemy_class.max_dexterity).to eq max_dexterity
            expect(enemy_class.min_defense).to eq min_defense
            expect(enemy_class.max_defense).to eq max_defense
          end

          describe '#roll_max_life' do
            it 'returns max life' do
              expected_min_result = min_vitality * enemy_params[:level]
              expected_max_result = max_vitality * enemy_params[:level]
              expect(subject.roll_max_life).to be_between(expected_min_result, expected_max_result)
            end
          end
        end
      end
    end
  end
end
