# frozen_string_literal: true

require "./lib/log_parser/printer/visits_count"

RSpec.describe LogParser::Printer::VisitsCount do
  let(:writer) { described_class.new(result) }

  describe "#call" do
    subject { writer.call(order) }

    context "descending order" do
      let(:order) { :desc }
      let(:result) do
        [
          { path: "/about", visits_counter: 15 },
          { path: "/help",  visits_counter: 12 },
        ]
      end

      it "correctly formats and prints the data with correct header" do
        expect { subject }.to output(
          "#{LogParser::Printer::VisitsCount::HEADER_DESC}\n" \
          "/about          15 visits\n" \
          "/help           12 visits\n\n",
        ).to_stdout
      end
    end

    context "ascending order" do
      let(:order) { :asc }
      let(:result) do
        [
          { path: "/help",  visits_counter: 12 },
          { path: "/about", visits_counter: 15 },
        ]
      end

      it "correctly formats and prints the data with correct header" do
        expect { subject }.to output(
          "#{LogParser::Printer::VisitsCount::HEADER_ASC}\n" \
          "/help           12 visits\n" \
          "/about          15 visits\n\n",
        ).to_stdout
      end
    end
  end
end
