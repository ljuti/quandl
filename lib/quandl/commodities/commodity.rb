module Quandl
  module Commodities
    class Commodity < Quandl::Dataset
      def initialize(*args)
        options     = args.extract_options!
        @dataset_id = options[:id]
        @format     = :json
        @data       = get_data
      end

      def current_price
        @current_price ||= get_current_price
      end

      def price(*args)
        options = args.extract_options!
        unless options.empty?
          price_data = {}
          if options[:date]
            price_for_date = @data["data"].select{ |price| price.first == options[:date] }.first
            price_data = format_price_data(price_for_date)
          else
            price_data = current_price
          end

          if options[:currency]
            return price_data[options[:currency]]
          end
          price_data
        else
          current_price
        end
      end

      private

      def get_current_price
        price = @data["data"].first
        format_price_data(price)
      end

      def format_price_data(price_data)
        { date: price_data[0], usd: price_data[1], gbp: price_data[2], eur: price_data[3] }
      end
    end
  end
end