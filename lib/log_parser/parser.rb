# frozen_string_literal: true

module LogParser
  class Parser

    def initialize(log_file:, mapper:, result:)
      @log_file = log_file
      @mapper   = mapper
      @result   = result
    end

    def call
      log_file.each do |row|
        row_data = mapper.call(row)

        result.add(**row_data)
      end
      log_file.close

      result
    end

    private

    attr_reader :log_file, :mapper, :result

  end
end
