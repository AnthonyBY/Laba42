# frozen_string_literal: true

class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, uniqueness: { scope: :project_id }

  STATUS = { waiting: 0, accept: 1, denied: 2, closed: 3, quit: 4 }.freeze
  enum apply_status: STATUS
end
