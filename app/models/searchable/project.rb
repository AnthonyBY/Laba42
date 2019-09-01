# frozen_string_literal: true

module Searchable
  module Project
    extend ActiveSupport::Concern
    include PgSearch::Model

    included do
      pg_search_scope(
        :search,
        against: %i[title info],
        using: { tsearch: { prefix: true } }
      )
    end
  end
end
