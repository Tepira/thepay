# encoding: utf-8

module ThePay
  ERRORS = {
    # TODO
  }

  class << self
    def get_error_description(code)
      return ERRORS[code.to_i]
    end
  end
end
