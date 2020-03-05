# frozen_string_literal: true

require_relative "base"

module LogParser
  module Printer
    class UniqueViews < Base

      HEADER = "List of webpages with most unique page views ordered from most unique pages views " \
               "to less unique page views:"

      def header
        HEADER
      end

      def format_data(data)
        "#{data[:path].ljust(15)} #{data[:unique_ip_addresses].size} unique views"
      end

    end
  end
end
