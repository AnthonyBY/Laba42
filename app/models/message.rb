# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user

  validates :body_message, presence: true
end
