# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include PgSearch::Model
  pg_search_scope :search_by_projects,
                  against: %i[title info],
                  using: { tsearch: { prefix: true }}

  self.abstract_class = true
end
