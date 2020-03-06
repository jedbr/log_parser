# frozen_string_literal: true

require "./lib/log_parser/printer/unique_views"

RSpec.describe LogParser::Printer::UniqueViews do
  let(:writer) { described_class.new(result) }

  describe "#call" do
    subject { writer.call(order) }

    context "descending order" do
      let(:order) { :desc }
      let(:result) do
        [
          { path: "/about", unique_ip_addresses: ["1.1.1.1", "2.2.2.2"] },
          { path: "/help",  unique_ip_addresses: ["3.3.3.3"] },
        ]
      end

      it "correctly formats and prints the data with correct header" do
        expect { subject }.to output(
          "#{LogParser::Printer::UniqueViews::HEADER_DESC}\n" \
          "/about          2 unique views\n" \
          "/help           1 unique views\n\n",
        ).to_stdout
      end
    end

    context "ascending order" do
      let(:order) { :asc }
      let(:result) do
        [
          { path: "/help",  unique_ip_addresses: ["3.3.3.3"] },
          { path: "/about", unique_ip_addresses: ["1.1.1.1", "2.2.2.2"] },
        ]
      end

      it "correctly formats and prints the data with correct header" do
        expect { subject }.to output(
          "#{LogParser::Printer::UniqueViews::HEADER_ASC}\n" \
          "/help           1 unique views\n" \
          "/about          2 unique views\n\n",
        ).to_stdout
      end
    end
  end
end
