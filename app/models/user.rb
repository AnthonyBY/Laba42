# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :projects, dependent: :destroy
  validates :name, presence: true
  USER_ROLES = {customer: 0, developer: 1}.freeze
  enum role: USER_ROLES

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.assign_attributes(
        name: auth.info.name,
        password: Devise.friendly_token,
        email: auth.info.email,
        token: auth.credentials.token,
        expires: auth.credentials.expires,
        expires_at: auth.credentials.expires_at,
        refresh_token: auth.credentials.refresh_token
      )
    end
  end
end
