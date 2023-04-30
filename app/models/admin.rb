# frozen_string_literal: true

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :team_name, presence: { message: 'が入力されていません' }
  validates :email, {  presence: true,
                       format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false } }
end
