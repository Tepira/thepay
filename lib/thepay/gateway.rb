# encoding: utf-8

require 'net/http'
require 'net/https'

module ThePay
  class Gateway
    attr_reader :merchant_id, :account_id, :password, :gateway_url, :value, :currency, :description, :merchant_data,
                :customer_email, :return_url, :back_to_eshop_url, :merchant_specific_symbol

    def initialize(options = {})
      @merchant_id              = options[:merchant_id]
      @account_id               = options[:account_id]
      @password                 = options[:password]
      @gateway_url              = options[:gateway_url] || 'https://www.thepay.cz/gate'
      @value                    = options[:value]
      @currency                 = options[:currency] || 'CZK'
      @descritpion              = options[:description]
      @merchant_data            = options[:merchant_data]
      @customer_email           = options[:customer_email]
      @return_url               = options[:return_url]
      @back_to_eshop_url        = options[:back_to_eshop_url]
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
      connection = Net::HTTP.new(gateway_url, 443)
      connection.use_ssl = true

      http_response = connection.start do |http|
        post = Net::HTTP::Post.new(url)
        post.set_form_data(data)
        http.request(post)
      end

      if http_response.code == '200'
        response = Response.parse(http_response.body)
        verify!(response) if response.status == 'OK'

        return response
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
