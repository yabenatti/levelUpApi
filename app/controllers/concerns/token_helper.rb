module TokenHelper
  extend ActiveSupport::Concern
  MAXIMUM_TOKEN_PER_USER = 20

  def find_token(token_from_headers)
    self.authentication_tokens.detect do |token|
      token.authentication_token == token_from_headers
    end
  end

  def create_and_return_token
    token = self.authentication_tokens.build(
      platform: :ios,
      authentication_token: generate_authentication_token,
      last_used_at: DateTime.current
    )

    token.authentication_token
  end

  def create_and_return_token!
    token = self.authentication_tokens.create!(
      platform: "ios",
      authentication_token: generate_authentication_token,
      last_used_at: DateTime.current
    )

    token.authentication_token
  end

  module ClassMethods
    def expire_token(resource, request)
      request.headers["Authorization"] =~ /^Token (.+)$/
      resource.find_token($~[1]).try(:destroy)
    end

    def purge_old_tokens
      self.authentication_tokens
        .order(last_used_at: :desc)
        .offset(MAXIMUM_TOKEN_PER_USER)
        .destroy_all
    end
  end

  private

    def generate_authentication_token
      Digest::SHA1.hexdigest("#{Time.now}-#{self.id}-#{self.updated_at}")
    end
end
