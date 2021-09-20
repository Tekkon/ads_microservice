# frozen_string_literal: true

class Ad < ApplicationRecord
  belongs_to :user

  validates :title, :description, :city, presence: true
end
