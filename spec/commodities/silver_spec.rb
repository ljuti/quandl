require 'spec_helper'
require 'quandl'

describe Quandl::Commodities::Silver do
  describe "default attributes" do
    it "includes HTTParty methods" do
      Quandl::Commodities::Silver.should include HTTParty
    end

    it "has base URL set to Quandl API" do
      Quandl::Commodities::Silver.base_uri.should == "http://www.quandl.com/api/v1"
    end
  end

  describe "GET commodity" do
    let(:commodity) { Quandl::Commodities::Silver.new }

    before do
      VCR.insert_cassette "dataset", record: :new_episodes
    end

    it "returns the current price of gold" do
      expect(commodity.current_price).to be_instance_of(Hash)
      expect(commodity.current_price[:date]).to eq(commodity.data["to_date"])
      expect(commodity.current_price.keys).to include(:date, :usd, :gbp, :eur)
    end

    after do
      VCR.eject_cassette
    end
  end
end