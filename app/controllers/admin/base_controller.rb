module Admin
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_admin, if: -> { Rails.env.production? }

    private

    def authenticate_admin
      username = ENV["ADMIN_USERNAME"]
      password = ENV["ADMIN_PASSWORD"]

      unless username.present? && password.present?
        render plain: "Admin access is not configured.", status: :service_unavailable
        return
      end

      authenticate_or_request_with_http_basic("Portfolio admin") do |submitted_username, submitted_password|
        secure_match?(submitted_username, username) && secure_match?(submitted_password, password)
      end
    end

    def secure_match?(submitted_value, expected_value)
      ActiveSupport::SecurityUtils.secure_compare(
        Digest::SHA256.hexdigest(submitted_value.to_s),
        Digest::SHA256.hexdigest(expected_value.to_s)
      )
    end
  end
end
