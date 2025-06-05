class Movie < ApplicationRecord
  has_one_attached :image

  validates :title, :category, :description, :year, presence: true
end
