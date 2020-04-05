module Hiro
  module Characters
    class Enemy
      include Game::Errors

      attr_reader :enemy_class,
                  :max_life,
                  :level,
                  :strength,
                  :dexterity,
                  :defense,
                  :min_damage,
                  :max_damage,
                  :weapon
      attr_accessor :x, :y, :life

      def initialize(x:, y:, enemy_class_attributes:, weapon_attributes:, level:, name: nil)
        @x = x
        @y = y
        @name = name
        @enemy_class = Struct::EnemyClass.new(enemy_class_attributes)
        @weapon = Struct::Weapon.new(weapon_attributes)
        @level = level
        @max_life = roll_max_life
        @life = @max_life
        @min_damage = weapon.min_damage
        @max_damage = weapon.max_damage
        @dexterity = roll_dexterity
        @defense = roll_defense

        super(self)
      end

      def name
        @name || type
      end

      def type
        enemy_class.type
      end

      def alive?
        life.positive?
      end

      def dead?
        !alive?
      end

      def lose_life(amount)
        @life -= amount
      end

      def roll_max_life
        min_possible_vitality = enemy_class.min_vitality * level
        max_possible_vitality = enemy_class.max_vitality * level
        rand(min_possible_vitality..max_possible_vitality)
      end

      def roll_defense
        rand(enemy_class.min_defense..enemy_class.max_defense)
      end

      def roll_dexterity
        rand(enemy_class.min_dexterity..enemy_class.max_dexterity)
      end

      Struct.new(
        'EnemyClass',
        :type,
        :min_vitality,
        :max_vitality,
        :min_dexterity,
        :max_dexterity,
        :min_defense,
        :max_defense,
        keyword_init: true
      )
    end

    Struct.new('Weapon', :name, :min_damage, :max_damage, keyword_init: true) do
      def roll_attack_damage
        rand(min_damage..max_damage)
      end
    end
  end
end
