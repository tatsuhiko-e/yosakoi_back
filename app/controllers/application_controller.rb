# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseHackFakeSession
  include ActionController::Cookies
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action do
    I18n.locale = :ja
  end
end
