class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_currency

  def current_currency
    @current_currency ||= Currency.by_abbr(Rails.configuration.container[:current_currency_abbr]).last
  end
end
