class DeviseLoginFailure < Devise::FailureApp
  def redirect_url
    root_path
  end

  def respond
    http_auth? ? http_auth : redirect
  end
end