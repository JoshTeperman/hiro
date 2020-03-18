module Hiro
  module Characters
    class Enemy
      include Game::Errors

      attr_reader :name,
                  :enemy_class,
                  :max_life,
                  :level,
                  :strength,
                  :dexterity,
                  :defense,
                  :min_damage,
                  :max_damage
      attr_accessor :x, :y, :life

      def initialize(x:, y:, enemy_class_attributes:, level:, name: nil)
        @x = x
        @y = y
        @name = name
        @enemy_class = Struct::EnemyClass.new(enemy_class_attributes)
        @level = level
        @max_life = roll_max_life
        @life = @max_life
        @min_damage = enemy_class.min_damage
        @max_damage = enemy_class.max_damage
        @dexterity = roll_dexterity
        @defense = roll_defense

        super(self)
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
        :min_damage,
        :max_damage,
        :min_dexterity,
        :max_dexterity,
        :min_defense,
        :max_defense,
        keyword_init: true
      )
    end
  end
end
