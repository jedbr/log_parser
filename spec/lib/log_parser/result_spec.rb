# frozen_string_literal: true

require "./lib/log_parser/result"

RSpec.describe LogParser::Result do
  describe "#add" do
    let(:result)     { described_class.new }

    let(:path)       { "/about" }
    let(:ip_address) { "192.168.1.1" }

    subject { result.add(path: path, ip_address: ip_address) }

    let(:path_data) do
      { visits_counter: 1, unique_ip_addresses: Set.new([ip_address]) }
    end

    it "adds data the store" do
      expect(result).to eq({})

      expect(subject).to eq(path_data)

      expect(result).to eq({ path => path_data })
    end
  end

  let(:store) do
    {
      "/home"      => { visits_counter: 4, unique_ip_addresses: Set.new(["1.1.1.1", "2.2.2.2"]) },
      "/help"      => { visits_counter: 5, unique_ip_addresses: Set.new(["1.1.1.1"]) },
      "/contact/1" => { visits_counter: 3, unique_ip_addresses: Set.new(["1.1.1.1", "2.2.2.2", "3.3.3.3"]) },
    }
  end

  describe "#to_a" do
    subject { described_class.new(store).to_a }

    it "converts result to an Array" do
      expect(subject).to match_array(
        [
          { path: "/home",      visits_counter: 4, unique_ip_addresses: Set.new(["2.2.2.2", "1.1.1.1"]) },
          { path: "/help",      visits_counter: 5, unique_ip_addresses: Set.new(["1.1.1.1"]) },
          { path: "/contact/1", visits_counter: 3, unique_ip_addresses: Set.new(["1.1.1.1", "2.2.2.2", "3.3.3.3"]) },
        ],
      )
    end
  end

  describe "#by_visits_count" do
    subject { described_class.new(store).by_visits_count }

    it "returns an Array of log data ordered by visits count descending" do
      expect(subject).to eq(
        [
          { path: "/help",      visits_counter: 5, unique_ip_addresses: Set.new(["1.1.1.1"]) },
          { path: "/home",      visits_counter: 4, unique_ip_addresses: Set.new(["2.2.2.2", "1.1.1.1"]) },
          { path: "/contact/1", visits_counter: 3, unique_ip_addresses: Set.new(["1.1.1.1", "2.2.2.2", "3.3.3.3"]) },
        ],
      )
    end
  end

  describe "#by_unique_views" do
    subject { described_class.new(store).by_unique_views }

    it "returns an Array of log data ordered by number of unique views descending" do
      expect(subject).to eq(
        [
          { path: "/contact/1", visits_counter: 3, unique_ip_addresses: Set.new(["1.1.1.1", "2.2.2.2", "3.3.3.3"]) },
          { path: "/home",      visits_counter: 4, unique_ip_addresses: Set.new(["2.2.2.2", "1.1.1.1"]) },
          { path: "/help",      visits_counter: 5, unique_ip_addresses: Set.new(["1.1.1.1"]) },
        ],
      )
    end
  end
end
