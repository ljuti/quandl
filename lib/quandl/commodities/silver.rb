module Quandl
  module Commodities
    class Silver < Commodity
      def initialize
        @dataset_id = "OFDP/SILVER_5"
        @format     = :json
        @data       = get_data
      end
    end
  end
end