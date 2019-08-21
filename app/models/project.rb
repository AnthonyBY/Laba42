# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :info, presence: true

   include PgSearch::Model
  pg_search_scope :search_by_projects,
                  against: %i[title info],
                  using: { tsearch: { prefix: true }}
end
