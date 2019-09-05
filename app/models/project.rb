# frozen_string_literal: true

class Project < ApplicationRecord
  before_save :skills_parse
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
  validate :validate_deadline_date

  include Searchable::Project

  COST_TYPE = { price: 0, contract_price: 1, free: 2 }.freeze
  enum cost_type: COST_TYPE

  TYPE_TASK = { project_type: 0, test_type: 1 }.freeze
  enum project_type: TYPE_TASK

  protected

  def validate_deadline_date
    errors.add(:deadline, 'is invalid') if deadline? && Date.today >= deadline
  end

  def skills_parse
    self.skills = skills.split(' ')
  end
end
