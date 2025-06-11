# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Origins allowed to make requests (change to your frontend domains)
    origins "https://your-frontend-domain.com", "http://localhost:3000"

    resource "*",
             headers: :any,                     # Allow all headers
             methods: [ :get, :post, :put, :patch, :delete, :options, :head ], # Allowed HTTP methods
             credentials: true,                 # Allow cookies/auth headers (useful with Devise session)
             expose: [ "Authorization" ]          # Expose headers like Authorization to the client (JWT tokens, for example)
  end

  # Example of allowing public API access from anywhere
  # allow do
  #   origins '*'
  #   resource '/public_api/*',
  #     headers: :any,
  #     methods: [:get, :options]
  # end
end
