OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "372858379447558", "faabe0159b9a1b2628aa128f89d1ce17"
end
