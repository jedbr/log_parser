# frozen_string_literal: true

require "./lib/log_parser/printer/visits_count"

RSpec.describe LogParser::Printer::VisitsCount do
  let(:writer) do
    result = [
      { path: "/about", visits_counter: 15 },
      { path: "/help",  visits_counter: 12 },
    ]

    described_class.new(result)
  end

  describe "#call" do
    subject { writer.call }

    it "correctly formats and prints the data" do
      expect { subject }.to output(
        "#{LogParser::Printer::VisitsCount::HEADER}\n" \
        "/about          15 visits\n" \
        "/help           12 visits\n\n",
      ).to_stdout
    end
  end
end
