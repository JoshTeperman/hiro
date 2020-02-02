module Hiro
  module Characters
    class Npc
      include Hiro::Game::Errors
      def initialize
        super(self)
      end
    end
  end
end
