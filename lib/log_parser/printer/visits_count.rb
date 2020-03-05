# frozen_string_literal: true

require_relative "base"

module LogParser
  module Printer
    class VisitsCount < Base

      HEADER = "List of webpages with most page views ordered from most pages views to less page views:"

      def header
        HEADER
      end

      def format_data(data)
        "#{data[:path].ljust(15)} #{data[:visits_counter]} visits"
      end

    end
  end
end
