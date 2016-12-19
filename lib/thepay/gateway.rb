# encoding: utf-8

require 'net/http'
require 'net/https'

module ThePay
  class Gateway
    attr_reader :merchant_id, :account_id, :password, :gateway_url, :value, :currency, :description, :merchant_data,
                :customer_email, :return_url, :back_to_eshop_url, :merchant_specific_symbol, :method_id

    def initialize(options = {})
      @password                 = options[:password]                  || 'my$up3rsecr3tp4$$word'
      @gateway_url              = options[:gateway_url]               || 'https://www.thepay.cz/demo-gate?'

      @merchant_id              = options[:merchant_id]               || 1
      @account_id               = options[:account_id]                || 3
      @value                    = options[:value]                     || 120
      @currency                 = options[:currency]                  || 'CZK'
      @description              = options[:description]               || 'testdescription'
      @merchant_data            = options[:merchant_data]             || 'returned'
      @customer_email           = options[:customer_email]            || 'test%40test.com'
      @return_url               = options[:return_url]                || 'httplocalhost3000'
      @back_to_eshop_url        = options[:back_to_eshop_url]         || 'httplocalhost3000'
      @merchant_specific_symbol = options[:merchant_specific_symbol]  || 12354367
    end

    # Get url to payment
    def get_payment_url(method)
      data = prepare_data(method)
      query = URI.encode_www_form(data)
      payment_url = gateway_url + query
    end

    private
    def prepare_data(method)
      data = {
        'merchantId' => merchant_id,
        'accountId' => account_id,
        'value' => "#{'%.02f' % value}",
        'merchantData' => merchant_data,
        'returnUrl' => return_url,
        'backToEshopUrl' => back_to_eshop_url,
        'methodId' => method,
        'password' => password,
      }

      out = ''
      data.each do |d,e|
        out = out + (d + '=' + e.to_s + '&')
      end
      out = out[0...-1]

      sig = ThePay::Signature.generate_md5(out)
      data['signature'] = sig
      data.except!('password')
      return data
    end



  end
end
