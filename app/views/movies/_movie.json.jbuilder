json.extract! movie, :id, :title, :category, :description, :year, :image, :created_at, :updated_at
json.url movie_url(movie, format: :json)
