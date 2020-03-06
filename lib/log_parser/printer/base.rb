# frozen_string_literal: true

module LogParser
  class Printer
    class Base

      HEADER_DESC = nil
      HEADER_ASC  = nil

      def initialize(result)
        @result = result
      end

      def call(order = :desc)
        header = header(order)
        puts header if header

        result.each do |data|
          puts format_data(data)
        end

        puts
      end

      private

      attr_reader :result

      def header(order)
        order == :desc ? self.class::HEADER_DESC : self.class::HEADER_ASC
      end

      def format_data(data)
        # Implement in subclass
      end

    end
  end
end
