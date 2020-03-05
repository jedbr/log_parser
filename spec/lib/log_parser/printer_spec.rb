# frozen_string_literal: true

require "./lib/log_parser/printer"

RSpec.describe LogParser::Printer do
  let(:result) do
    instance_double(LogParser::Result, to_a: [
      { path: "/about", visits_counter: 15, unique_ip_addresses: ["1.1.1.1", "2.2.2.2"] },
      { path: "/help",  visits_counter: 12, unique_ip_addresses: ["3.3.3.3"] },
    ])
  end
  let(:printer) do
    described_class.new(result: result, order: order, type: type)
  end

  describe "#compose" do
    subject { printer.compose }

    context "when order is :asc" do
      let(:order) { :asc }

      context "when type is :both" do
        let(:type) { :both }

        before do
          expect(result).to receive(:by_visits_count).with(:asc)
          expect(result).to receive(:by_unique_views).with(:asc)
        end

        it "uses both printers" do
          expect(subject.size).to eq(2)
        end
      end

      context "when type is :visits" do
        let(:type) { :visits }

        before do
          expect(result).to receive(:by_visits_count).with(:asc)
          expect(result).not_to receive(:by_unique_views)
        end

        it "uses VisitsCount printer" do
          expect(subject.size).to eq(1)
          expect(subject.first).to be_a(LogParser::Printer::VisitsCount)
        end
      end

      context "when type is :unique" do
        let(:type) { :unique }

        before do
          expect(result).not_to receive(:by_visits_count)
          expect(result).to receive(:by_unique_views).with(:asc)
        end

        it "uses UniqueViews printer" do
          expect(subject.size).to eq(1)
          expect(subject.first).to be_a(LogParser::Printer::UniqueViews)
        end
      end
    end

    context "when order is :desc" do
      let(:order) { :desc }

      context "when type is :both" do
        let(:type) { :both }

        before do
          expect(result).to receive(:by_visits_count).with(:desc)
          expect(result).to receive(:by_unique_views).with(:desc)
        end

        it "uses both printers" do
          expect(subject.size).to eq(2)
        end
      end

      context "when type is :visits" do
        let(:type) { :visits }

        before do
          expect(result).to receive(:by_visits_count).with(:desc)
          expect(result).not_to receive(:by_unique_views)
        end

        it "uses VisitsCount printer" do
          expect(subject.size).to eq(1)
          expect(subject.first).to be_a(LogParser::Printer::VisitsCount)
        end
      end

      context "when type is :unique" do
        let(:type) { :unique }

        before do
          expect(result).not_to receive(:by_visits_count)
          expect(result).to receive(:by_unique_views).with(:desc)
        end

        it "uses UniqueViews printer" do
          expect(subject.size).to eq(1)
          expect(subject.first).to be_a(LogParser::Printer::UniqueViews)
        end
      end
    end
  end

  describe "#print" do
    subject { printer.print }

    let(:order) { :desc }
    let(:type)  { :both }

    context "when printers are not composed" do
      it "does not fail" do
        expect { subject }.not_to raise_error
      end
    end

    context "when printers were composed" do
      let(:visits_count_printer) { instance_double(LogParser::Printer::VisitsCount) }
      let(:unique_views_printer) { instance_double(LogParser::Printer::UniqueViews) }

      before do
        expect(result).to receive(:by_visits_count).with(:desc)
        expect(result).to receive(:by_unique_views).with(:desc)

        expect(LogParser::Printer::VisitsCount).to receive(:new).and_return(visits_count_printer)
        expect(LogParser::Printer::UniqueViews).to receive(:new).and_return(unique_views_printer)

        printer.compose
      end

      it "calls every printer" do
        expect(visits_count_printer).to receive(:call)
        expect(unique_views_printer).to receive(:call)

        subject
      end
    end
  end
end
