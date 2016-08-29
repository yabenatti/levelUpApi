class AuthenticationTokenStrategy < ::Warden::Strategies::Base

  def authenticate!
    byebug
    user = User.find_by(id: params['uid'])
    return fail!(I18n::t('session.logout.authentication_token.failed')) unless user

    token = user.find_token(authentication_token)
    if token
      touch_token(token)
      return success!(user)
    end
    
    fail!(I18n::t('session.logout.authentication_token.failed'))
  end

  def store?
    false
  end

  private

    # Recupera apenas a parte do token do valor de 'Authorization'
    def authentication_token
      if header && header =~ /^Token (.+)$/
        $~[1]
      else
        fail!(I18n::t('session.logout.authentication_token.failed'))
      end
    end

    # Recupera o valor da chave 'Authorization' do Header da chamada
    def header
      request.env["HTTP_AUTHORIZATION"]
    end

    def touch_token(token)
      token.update_attribute(:last_used_at, DateTime.current) if token.last_used_at < 1.hour.ago
    end
end