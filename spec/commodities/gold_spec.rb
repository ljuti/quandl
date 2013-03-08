require 'spec_helper'
require 'quandl'

describe Quandl::Commodities::Gold do
  describe "default attributes" do
    it "includes HTTParty methods" do
      Quandl::Commodities::Gold.should include HTTParty
    end

    it "has base URL set to Quandl API" do
      Quandl::Commodities::Gold.base_uri.should == "http://www.quandl.com/api/v1"
    end
  end

  describe "GET commodity" do
    let(:gold) { Quandl::Commodities::Gold.new }

    before do
      VCR.insert_cassette "dataset", record: :new_episodes
    end

    it "returns the current price of gold" do
      expect(gold.current_price).to be_instance_of(Hash)
      expect(gold.current_price[:date]).to eq(gold.data["to_date"])
      expect(gold.current_price.keys).to include(:date, :usd, :gbp, :eur)
      # expect(gold.current_price).to be_instance_of(Array)
      # expect(gold.current_price.first).to eq(gold.data["to_date"])
      # puts gold.current_price
    end

    after do
      VCR.eject_cassette
    end
  end
end