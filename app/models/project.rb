# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :applies, dependent: :destroy

  validates :title, presence: true
  validates :info, presence: true

  include Searchable::Project
end
