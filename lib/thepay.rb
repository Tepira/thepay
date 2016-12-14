# encoding: utf-8

require 'yaml'

require 'thepay/version'
require 'thepay/response'
require 'thepay/gateway'
require 'thepay/signature'
require 'thepay/errors'

module ThePay

  @@pos_table = {}

  class SignatureInvalid < StandardError; end
  class RequestFailed < StandardError; end

  class << self

    # Loads configuration from YAML
    def load_pos_from_yaml(filename)
      if File.exist?(filename)
        config = YAML.load_file(filename)
        config.each do |name, config|
          gateway = Gateway.new(
            :merchant_id => config['merchant_id'],
            :account_id => config['account_id'],
            :password => config['password'],
            :gateway_url => config['gateway_url'],
          )
          @@pos_table[name] = pos
        end

        true
      else
        false
      end
    end
  end
end
