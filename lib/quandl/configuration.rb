module Quandl
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :method].freeze
    VALID_OPTIONS_KEYS    = [:api_key, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = "http://www.quandl.com/api/v1"
    DEFAULT_METHOD        = :get

    DEFAULT_API_KEY       = nil
    DEFAULT_FORMAT        = :json

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.method   = DEFAULT_METHOD
      self.api_key  = DEFAULT_API_KEY
      self.format   = DEFAULT_FORMAT
    end

    def configure
      yield self
    end
  end
end