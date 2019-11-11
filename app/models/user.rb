# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise  :database_authenticatable, :registerable, :trackable,
          :recoverable, :rememberable, :validatable, :lockable,
          :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :projects, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :applied_to_projects, through: :applies, class_name: 'Project', foreign_key: 'project_id', source: :user
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  USER_ROLES = { customer: 0, developer: 1 }.freeze
  enum role: USER_ROLES
  SKILLS = [
    'Ruby', 'Java', 'Kotlin', 'Swift', 'Go', 'PHP', 'C++', 'C', 'Python',
    'JavaScript', 'C#', 'Rust', 'HTML', 'CSS', 'SQL', 'Visual Basic',
    '.NET', 'Objective-C'
  ].freeze

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

  def skills=(args)
    raise 'array expected' unless args.is_a?(Array)

    super
  end
end
