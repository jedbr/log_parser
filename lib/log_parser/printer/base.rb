# frozen_string_literal: true

module LogParser
  class Printer
    class Base

      def initialize(result)
        @result = result
      end

      def call
        puts header

        result.each do |data|
          puts format_data(data)
        end

        puts
      end

      private

      attr_reader :result

      def format_data(data)
        # Implement in subclass
      end

    end
  end
end
