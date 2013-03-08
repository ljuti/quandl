module Quandl
  module Commodities
    class Gold < Quandl::Dataset
      def initialize
        @dataset_id = "OFDP/GOLD_2"
        @format     = :json
        @data       = get_data
      end

      def current_price
        @current_price ||= get_current_price
      end

      private

      def get_current_price
        price = @data["data"].first
        data = { date: price[0], usd: price[1], gbp: price[2], eur: price[3] }
        data
      end
    end
  end
end