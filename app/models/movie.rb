class Movie < ApplicationRecord
  mount_uploader :image, PictureUploader
  validates :image, virus: true
  validates :title, :category, :description, :year, presence: true
end
