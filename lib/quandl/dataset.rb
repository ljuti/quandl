require "httparty"

module Quandl
  class Dataset
    include HTTParty

    base_uri "http://www.quandl.com/api/v1"

    attr_accessor :dataset_id
    attr_accessor :format
    attr_accessor :data
    attr_accessor :source_code
    attr_accessor :code
    attr_accessor :name
    attr_accessor :description
    attr_accessor :columns

    def initialize(*args)
      options     = args.extract_options!
      @dataset_id = options[:id]
      @format     = :json
      @data       = get_data
      process_data
    end

    def after_initialize
      convert_columns
    end

    def raw_data
      self.class.get "/datasets/OFDP/GOLD_2.json"
    end

    def process_data
      @source_code  = @data["source_code"]
      @code         = @data["code"]
      @name         = @data["name"]
      @description  = @data["description"]
      @columns      = convert_columns(@data["column_names"])
    end

    def convert_columns(columns)
      unless columns.nil?
        columns.map!{ |name| name.downcase.to_sym }
      end
    end

    def current_price
      @current_price ||= get_current_price
    end

    def current_value
      @current_value ||= get_current_value
    end

    class << self
      def find
        true
      end
    end

    private

    def get_current_price
      price = @data["data"].first
    end

    def get_current_value
      current = {}
      values = @data["data"].first
      @columns.each_with_index do |column, index|
        current[column] = values[index]
      end
      current
    end

    def get_data
      self.class.get("/datasets/#{@dataset_id}.#{@format.to_s}")
    end
  end
end