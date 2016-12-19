# encoding: utf-8

require 'digest'

module ThePay
  class SignatureInvalid < StandardError
  end

  class Signature

    # Generates md5 signature
    def self.generate_md5(*values)
      Digest::MD5.hexdigest(values.join)
    end

    def self.generate_sha256(*values)
      Digest::SHA256.hexdigest(values.join)
    end

    # Verify signature
    def self.verify!(expected, *values)
      raise SignatureInvalid if expected != generate(values)
    end
  end
end
