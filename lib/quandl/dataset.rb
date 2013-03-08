require "httparty"

module Quandl
  class Dataset
    include HTTParty

    base_uri "http://www.quandl.com/api/v1"

    attr_accessor :dataset_id
    attr_accessor :format
    attr_accessor :data

    def initialize
      @dataset_id = nil
      @format = :json
    end

    def raw_data
      self.class.get "/datasets/OFDP/GOLD_2.json"
    end

    def data
      @data ||= get_data
    end

    class << self
      def find
        true
      end
    end

    private

    def get_data
      self.class.get("/datasets/#{@dataset_id}.#{@format.to_s}")
    end
  end
end