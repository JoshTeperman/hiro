module Hiro
  module Game
    module Errors
      attr_accessor :errors

      def initialize(base)
        @base = base
        @errors = []
      end

      def add_error(message, attribute = :base)
        error = Struct::Error.new(@base.class, attribute, message)
        @errors << error

        error
      end

      def valid?
        errors.empty?
      end

      def error_messages
        errors.map do |error|
          # "Name must be a valid string" Error on Player (:name)"
          "'#{error.message}' Error on #{error.base_class_name} (:#{error.attribute})"
        end
      end

      Struct.new('Error', :klass, :attribute, :message) do
        def base_class_name
          klass.name.split('::').last
        end
      end
    end
  end
end
