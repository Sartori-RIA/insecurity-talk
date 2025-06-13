class Movie < ApplicationRecord
  ALLOWED_FILE_TYPES = %w[image/png image/jpeg]
  has_one_attached :image

  validates :title, :category, :description, :year, presence: true
  validates :image, content_type: ALLOWED_FILE_TYPES, size: { less_than: 5.megabytes }

  after_create_commit :rename_file

  private

  def rename_file
    return unless image.attached?

    new_filename = "#{SecureRandom.uuid}#{File.extname(image.filename.to_s)}"
    image.blob.update!(filename: new_filename)
  end
end
