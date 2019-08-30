# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :comment_owner, polymorphic: true
  belongs_to :user

  validates :content, presence: true
end
