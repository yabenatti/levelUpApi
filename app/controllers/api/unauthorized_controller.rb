class Api::UnauthorizedController < ActionController::Metal
  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.status = 401
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    self.content_type = 'application/json'
    self.response_body = { status: 2, messages: I18n.t('session.bad_credentials') }.to_json
  end
end