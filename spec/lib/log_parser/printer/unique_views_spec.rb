# frozen_string_literal: true

require "./lib/log_parser/printer/unique_views"

RSpec.describe LogParser::Printer::UniqueViews do
  let(:writer) do
    result = [
      { path: "/about", unique_ip_addresses: ["1.1.1.1", "2.2.2.2"] },
      { path: "/help",  unique_ip_addresses: ["3.3.3.3"] },
    ]

    described_class.new(result)
  end

  describe "#call" do
    subject { writer.call }

    it "correctly formats and prints the data" do
      expect { subject }.to output(
        "#{LogParser::Printer::UniqueViews::HEADER}\n" \
        "/about          2 unique views\n" \
        "/help           1 unique views\n\n",
      ).to_stdout
    end
  end
end
