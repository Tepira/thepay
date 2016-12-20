# encoding: utf-8

require 'net/http'
require 'net/https'
require 'json'

module ThePay
  class Api
    attr_reader :merchant_id, :password, :api_url, :account_id

    def initialize(options = {})
      @password                 = options[:password]                  || 'my$up3rsecr3tp4$$word'
      @api_url                  = options[:gateway_url]               || 'https://www.thepay.cz/demo-gate/api/data/'
      @account_id               = options[:account_id]                || 3
      @merchant_id              = options[:merchant_id]               || 1
    end

    # Gets transaction status
    def get_payments_method
      add = { :only_active => 1 }
      res = send_request(add)
      return res
    end

    def get_payment_instructions
      #TODO
    end

    def get_payment_state
      #TODO
    end

    # TODO more method for API

    private
    def send_request(values={})

      data = prepare_json(values)

      if res.code == '200'
        #response = Response.parse(res.body)
        #verify!(response) if response.status == 'OK'

        return res.body
      else
        # TODO raise RequestFailed
      end
    end

    def prepare_json(values)
      jsondata = {}
       jsondata.merge!('merchantId' => merchant_id)
       jsondata.merge!('onlyActive' => values[:only_active]) if values[:only_active]
      # ...
      # TODO add another json data
       jsondata.merge!('password' => password)

      out = ''
      jsondata.each do |d,e|
        out = out + (d + '=' + e.to_s + '&')
      end
      out = out[0...-1]

      sig = ThePay::Signature.generate_sha256(out)
      jsondata['signature'] = sig
      jsondata.except!('password')
      return jsondata
    end

  end
end
