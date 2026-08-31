class ApplicationController < ActionController::Base
  around_action :switch_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def switch_locale(&action)
    session[:locale] = params[:locale] if I18n.available_locales.map(&:to_s).include?(params[:locale])
    I18n.with_locale(session[:locale] || I18n.default_locale, &action)
  end
end
