module Hiro
  module Game
    module Errors
      attr_accessor :errors
      def initialize(base)
        @base = base
        @errors = []
      end

      def add_error(attribute, message)
        error = Struct::Error.new(@base, attribute, message)

        @errors << error
        error
      end

      Struct.new('Error', :klass, :attribute, :message)
    end
  end
end
