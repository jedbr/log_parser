# frozen_string_literal: true

require_relative "base"

module LogParser
  class Printer
    class VisitsCount < Base

      HEADER_DESC = "List of webpages with most page views ordered from most pages views to less page views:"
      HEADER_ASC  = "List of webpages with most page views ordered from less pages views to most page views:"

      def format_data(data)
        "#{data[:path].ljust(15)} #{data[:visits_counter]} visits"
      end

    end
  end
end
