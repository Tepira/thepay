# encoding: utf-8

require 'net/http'
require 'net/https'
require 'json'

module ThePay
  class Api
    attr_reader :merchant_id, :password, :api_url, :account_id,

    def initialize(options = {})
      @password                 = options[:password]                  || 'my$up3rsecr3tp4$$word'
      @api_url                  = options[:gateway_url]               || 'https://www.thepay.cz/demo-gate/api/data/'
      @account_id               = options[:account_id]                || 3
      @merchant_id              = options[:merchant_id]               || 1
    end

    # Gets transaction status
    def getPaymentsMethod
      send_request()
    end

    def getPaymentInstructions
      #TODO
    end

    def getPaymentState
      #TODO
    end

    # TODO more method for API

    private
    def send_request(options = {})
      data = prepare_data

      uri = URI('https://www.thepay.cz/demo-gate')
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(data)

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

    def prepare_data
      data = {
        'merchantId' => merchant_id,
        'password' => password,
      }

      out = ''
      data.each do |d,e|
        out = out + (d + '=' + e.to_s + '&')
      end

      sig = ThePay::Signature.generate_md5(out)
      data['signature'] = sig
      data.except!('password')
      return data
    end

  end
end
