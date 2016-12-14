# encoding: utf-8

module ThePay
  class Response < OpenStruct
    PATTERN = /^(\w+):(?:[ ])?(.*)$/

    # Parses response
    def self.parse(body)
      temp = body.gsub("\r", "")
      data = temp.scan(PATTERN)

      data_hash = {}
      data.each do |element|
        data_hash[element[0]] = element[1]
      end

      new(data_hash)
    end

  end
end
