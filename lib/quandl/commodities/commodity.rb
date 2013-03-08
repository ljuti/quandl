module Quandl
  module Commodities
    class Commodity < Quandl::Dataset
      def initialize(*id)
        @dataset_id = id
        @format = :json
      end

      def current_price
        @current_price ||= get_current_price
      end

      def price(*args)
        options = args.extract_options!
        unless options.empty?
          "Yay!"
        else
          current_price
        end
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