# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :applies, dependent: :destroy
  has_many :comments, as: :comment_owner, dependent: :destroy

  validates :title, presence: true
  validates :info, presence: true
  validates :deadline, presence: true
  validates :cost_type, presence: true
  validates :project_type, presence: true
  validates :cost, presence: true
  validates :skills, presence: true

  include Searchable::Project

  COST_TYPE = { price: 0, free: 1 }.freeze
  enum cost_type: COST_TYPE

  TYPE_TASK = { project_type: 0, test_type: 1 }.freeze
  enum project_type: TYPE_TASK

  STATUSES = { active: 0, notification_sent: 1, completed: 2, favorite: 3 }.freeze
  enum status: STATUSES, _prefix: true
end
