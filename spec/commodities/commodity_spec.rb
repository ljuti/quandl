require 'spec_helper'
require 'quandl'

describe Quandl::Commodities::Commodity do
  describe "default attributes" do
    it "includes HTTParty methods" do
      Quandl::Commodities::Commodity.should include HTTParty
    end

    it "has base URL set to Quandl API" do
      Quandl::Commodities::Commodity.base_uri.should == "http://www.quandl.com/api/v1"
    end
  end

  describe "GET commodity" do
    let(:commodity) { Quandl::Commodities::Commodity.new(id: "OFDP/GOLD_2") }

    before do
      VCR.insert_cassette "dataset", record: :new_episodes
    end

    describe ".price" do
      it "returns the current price if called without arguments" do
        expect(commodity.price).to eq(commodity.current_price)
      end
    end

    after do
      VCR.eject_cassette
    end
  end
end