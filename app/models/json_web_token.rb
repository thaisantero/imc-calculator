class JsonWebToken
  VALID_TOKEN = "valid_token".freeze

  class DecodeError < StandardError
    def message
      I18n.t("errors.invalid_token")
    end
  end

  def self.decode(token)
    raise DecodeError unless token_is_valid?(token)
  end

  def self.token_is_valid?(token)
    token == VALID_TOKEN
  end
end
