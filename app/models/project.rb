# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :info, presence: true
end
