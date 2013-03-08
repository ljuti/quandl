require 'spec_helper'
require 'quandl'

describe Quandl::Dataset do
  describe "default attributes" do
    it "includes HTTParty methods" do
      Quandl::Dataset.should include HTTParty
    end

    it "has base URL set to Quandl API" do
      Quandl::Dataset.base_uri.should == "http://www.quandl.com/api/v1"
    end
  end

  describe "GET dataset" do
    let(:dataset)   { Quandl::Dataset.new }
    let(:gold)      { Quandl::Dataset.new(id: "OFDP/GOLD_2") }
    let(:note_10y)  { Quandl::Dataset.new(id: "FRED/DGS10") }

    before do
      VCR.insert_cassette "dataset", record: :new_episodes
    end

    it "responds to class method #find" do
      dataset.class.should respond_to :find
    end

    it "parses API response from JSON to Hash" do
      dataset.raw_data.should be_instance_of Hash
    end

    it "returns a dataset and assigns data" do
      expect(dataset.raw_data["code"]).to eq("GOLD_2")
    end

    describe "dataset details" do
      it "has a source code" do
        expect(gold.source_code).to eq("OFDP")
      end

      it "has a dataset code" do
        expect(gold.code).to eq("GOLD_2")
      end

      it "has a name" do
        expect(gold.name).to eq("LBMA Gold Price: London Fixings P.M.")
      end

      it "has a description" do
        expect(gold.description).to eq("LBMA Gold Price: London Fixings P.M.. London Bullion Market Association (LBMA). Fixing levels are set per troy ounce.")
      end
    end

    describe "#current_value" do
      it "returns the current value of the dataset as a Hash" do
        expect(gold.current_value).to be_instance_of(Hash)
        expect(note_10y.current_value).to be_instance_of(Hash)
      end

      it "includes all columns specified in the dataset" do
        gold.columns.each do |column|
          expect(gold.current_value.keys).to include(column)
        end
      end

      it "includes the current value of the dataset" do
        data = gold.data["data"].first
        expect(gold.current_value).to eq({ date: data[0], usd: data[1], gbp: data[2], eur: data[3] })

        data = note_10y.data["data"].first
        expect(note_10y.current_value).to eq({ date: data[0], value: data[1] })
      end
    end

    describe "#current_price" do
      it "returns the current price for the dataset" do
        expect(gold.current_price).to be_instance_of(Array)
        expect(note_10y.current_price).to be_instance_of(Array)
        expect(gold.current_price.length).to be >= 2
        expect(note_10y.current_price.length).to be >= 2
        expect(gold.current_price[0]).to match(/\d{4}-\d{2}-\d{2}/)
        expect(note_10y.current_price[0]).to match(/\d{4}-\d{2}-\d{2}/)
      end
    end

    after do
      VCR.eject_cassette
    end
  end
end