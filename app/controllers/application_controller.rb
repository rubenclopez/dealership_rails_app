class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Helper function to simulate latency
  def simulate_latency
    sleep(rand(2)) if Rails.env == 'development'
  end
end
