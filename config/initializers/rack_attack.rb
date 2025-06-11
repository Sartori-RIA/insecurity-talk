# config/initializers/rack_attack.rb

class Rack::Attack
  ### 1. Allow requests from localhost (useful for development or container health checks)
  safelist("allow-localhost") do |req|
    %w[127.0.0.1 ::1].include?(req.ip)
  end

  ### 2. Block specific malicious IPs (add known bad IPs here)
  # blocklist('block-bad-ip') do |req|
  #   ['1.2.3.4', '5.6.7.8'].include?(req.ip)
  # end

  ### 3. Protect against brute-force attacks on login endpoint
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.ip
    end
  end

  ### 4. General rate limiting per IP
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  ### 5. Custom response for throttled requests
  self.blocklisted_response = lambda do |env|
    [
      429, # Too Many Requests
      { "Content-Type" => "application/json" },
      [ { error: "Too many requests. Please try again later." }.to_json ]
    ]
  end
end

### Enable Rack::Attack middleware
Rails.application.config.middleware.use Rack::Attack
