# frozen_string_literal: true

class LogParser
  class Mapper

    def call(row)
      path, ip_address = row.strip.split

      { path: path, ip_address: ip_address }
    end

  end
end
