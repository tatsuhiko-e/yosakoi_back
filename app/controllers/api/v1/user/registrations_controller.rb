# frozen_string_literal: true

module Api
  module V1
    module User
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        private

        def sign_up_params
          params.permit(:email, :password, :password_confirmation, :nickname)
        end
      end
    end
  end
end
