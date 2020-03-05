# frozen_string_literal: true

require_relative "printer/unique_views"
require_relative "printer/visits_count"

module LogParser
  class Printer

    def initialize(result:, order:, type:)
      @result = result
      @order  = order
      @type   = type
    end

    def compose
      @printers = [].tap do |printers|
        printers << Printer::VisitsCount.new(result.by_visits_count(order)) if %i(visits both).include?(type)
        printers << Printer::UniqueViews.new(result.by_unique_views(order)) if %i(unique both).include?(type)
      end
    end

    def print
      @printers&.each(&:call)
    end

    private

    attr_reader :result, :order, :type

  end
end
