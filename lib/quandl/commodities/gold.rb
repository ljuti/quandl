module Quandl
  module Commodities
    class Gold < Commodity
      def initialize
        @dataset_id = "OFDP/GOLD_2"
        @format     = :json
        @data       = get_data
      end
    end
  end
end