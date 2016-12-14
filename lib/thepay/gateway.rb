# encoding: utf-8

require 'net/http'
require 'net/https'

module ThePay
  class Gateway
    attr_reader :merchant_id, :account_id, :password, :gateway_url, :value, :currency, :description, :merchant_data,
                :customer_email, :return_url, :back_to_eshop_url, :merchant_specific_symbol

    def initialize(options = {})
      @merchant_id              = options[:merchant_id]               || 1
      @account_id               = options[:account_id]                || 3
      @password                 = options[:password]                  || 'my$up3rsecr3tp4$$word'
      @gateway_url              = options[:gateway_url]               || 'https://www.thepay.cz/demo-gate'
      @value                    = options[:value]                     || 120
      @currency                 = options[:currency]                  || 'CZK'
      @descritpion              = options[:description]               || 'test description'
      @merchant_data            = options[:merchant_data]             || 'returned value from gateway'
      @customer_email           = options[:customer_email]            || 'test@test.com'
      @return_url               = options[:return_url]                || 'http://localhost:3000'
      @back_to_eshop_url        = options[:back_to_eshop_url]         || ''
      @merchant_specific_symbol = options[:merchant_specific_symbol]
    end

    # Gets transaction status
    def get(options = {})
      send_request(options)
    end

    # Payment transaction
    def payment(options = {})
      send_request(options)
    end

    # Cancels transaction
    def cancel(options = {})
      send_request(options)
    end

    private
    def send_request(options = {})
      data = prepare_data(options)

      uri = URI('https://www.thepay.cz/demo-gate')
      req = Net::HTTP::Post.new(uri)
      req.set_form_data('merchantId' => '1', 'accountId' => '3', 'signature' => signature)

      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end

      if res.code == '200'
        #response = Response.parse(res.body)
        #verify!(response) if response.status == 'OK'

        return res.body
      else
        # TODO raise RequestFailed
      end
    end

    def prepare_data(options = {})
      sig = Signature.generate(options)

      {
        # TODO data for request as hash
      }
    end

  end
end
