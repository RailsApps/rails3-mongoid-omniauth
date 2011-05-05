Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'KEY', 'SECRET'
end
