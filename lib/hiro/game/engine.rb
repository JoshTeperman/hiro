module Hiro
  module Game
    class Engine
      attr_reader :window, :player

      def initialize(options)
        @window = Game::Window.new(map: OpenStruct.new(shape: [[' ', ' '], [' ', ' ']], entry_points: [[0, 0]], exit_points: [[0, 0]]))
        @player = Characters::Player.new(options[:saved_player])
      end
    end
  end
end

