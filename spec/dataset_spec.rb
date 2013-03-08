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
    let(:dataset) { Quandl::Dataset.new }

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

    after do
      VCR.eject_cassette
    end
  end
end