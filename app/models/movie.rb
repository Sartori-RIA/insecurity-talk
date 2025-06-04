class Movie < ApplicationRecord
  validates :title, :category, :description, :year, presence: true
end
