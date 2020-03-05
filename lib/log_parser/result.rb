# frozen_string_literal: true

require "forwardable"

module LogParser
  class Result

    extend Forwardable

    def initialize(store = nil)
      @store = store || Hash.new do |hash, path|
        hash[path] = { visits_counter: 0, unique_ip_addresses: Set.new }
      end
    end

    def add(path:, ip_address:)
      store[path][:visits_counter] += 1
      store[path][:unique_ip_addresses] << ip_address

      store[path]
    end

    def to_a
      store.map { |path, props| props.merge(path: path) }
    end

    def by_visits_count
      to_a.sort_by { |data| -data[:visits_counter] }
    end

    def by_unique_views
      to_a.sort_by { |data| -data[:unique_ip_addresses].size }
    end

    def_delegators :@store, :==

    private

    attr_reader :store

  end
end
