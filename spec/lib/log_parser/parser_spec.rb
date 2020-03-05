# frozen_string_literal: true

require "./lib/log_parser/parser"
require "./lib/log_parser/log_file"
require "./lib/log_parser/mapper"
require "./lib/log_parser/result"

module LogParser

  RSpec.describe Parser do
    let(:log_file) { LogFile.open("spec/fixtures/files/webserver.log") }
    let(:mapper)   { Mapper.new }
    let(:result)   { Result.new }

    let(:parser) do
      described_class.new(
        log_file: log_file,
        mapper:   mapper,
        result:   result,
      )
    end

    describe "#call" do
      subject { parser.call }

      it "correctly parses the log" do
        expect(subject).to eq(
          {
            "/home"      => { visits_counter: 1, unique_ip_addresses: Set.new(["2.2.2.2"]) },
            "/contact/1" => { visits_counter: 3, unique_ip_addresses: Set.new(["1.1.1.1", "2.2.2.2"]) },
            "/help"      => { visits_counter: 2, unique_ip_addresses: Set.new(["1.1.1.1"]) },
          },
        )
      end

      it "closes the log file" do
        expect { subject }.to change { log_file.closed? }.from(false).to(true)
      end
    end
  end

end
