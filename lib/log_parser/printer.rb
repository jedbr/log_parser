# frozen_string_literal: true

require_relative "printer/unique_views"
require_relative "printer/visits_count"

module LogParser
  class Printer

    def initialize(result:, order:, type:)
      @result   = result
      @order    = order
      @type     = type
      @printers = []
    end

    def compose
      printers.tap do |prntrs|
        prntrs << Printer::VisitsCount.new(result.by_visits_count(order)) if %i(visits both).include?(type)
        prntrs << Printer::UniqueViews.new(result.by_unique_views(order)) if %i(unique both).include?(type)
      end
    end

    def print
      printers.each { |printer| printer.call(order) }
    end

    private

    attr_reader :result, :order, :type, :printers

  end
end
