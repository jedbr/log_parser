# frozen_string_literal: true

require_relative "base"

module LogParser
  class Printer
    class UniqueViews < Base

      HEADER_DESC = "List of webpages with most unique page views ordered from most unique pages views " \
                    "to less unique page views:"
      HEADER_ASC  = "List of webpages with most unique page views ordered from less unique pages views " \
                    "to most unique page views:"

      def format_data(data)
        "#{data[:path].ljust(15)} #{data[:unique_ip_addresses].size} unique views"
      end

    end
  end
end
