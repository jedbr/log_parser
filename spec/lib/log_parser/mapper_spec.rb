# frozen_string_literal: true

require "./lib/log_parser/mapper"

RSpec.describe LogParser::Mapper do
  let(:mapper) { described_class.new }

  describe "#call" do
    subject { mapper.call(row) }

    let(:row) { "/about 192.168.1.1\n" }

    let(:correct_data) do
      { path: "/about", ip_address: "192.168.1.1" }
    end

    it "correctly parses the row" do
      expect(subject).to eq(correct_data)
    end
  end
end
