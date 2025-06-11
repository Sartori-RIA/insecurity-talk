# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  ### 1️⃣ Public API (/external/api/*) - accessible by anyone
  allow do
    origins "*"  # Allow requests from any origin (public)

    resource "/external/api/*",
             headers: :any,
             methods: [ :get, :post, :options, :head ], # Customize methods if needed
             expose: [ "Authorization" ]                # Expose headers if using tokens
  end

  ### 2️⃣ Internal API (/internal/api/*) - restricted to specific trusted origins
  allow do
    origins "https://trusted-internal-site.com", "https://another-trusted-site.com"

    resource "/internal/api/*",
             headers: :any,
             methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
             expose: [ "Authorization" ],                # Expose headers if using tokens
             credentials: true                       # Required if using cookies/sessions/auth
  end
end
