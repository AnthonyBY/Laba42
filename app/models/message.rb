# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user

  validates :body_message, presence: true

  AS_READ = { unread: 0, read: 1 }.freeze
  enum read_status: AS_READ, _prefix: true
end
