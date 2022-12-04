class Api::V1::Admin::SessionsController < ApplicationController
  def index
    if current_api_v1_admin
      render json: { is_login: true, data: current_api_v1_admin }
    else
      render json: { is_login: false, message: "ユーザーが存在しません" }
    end
  end
end
