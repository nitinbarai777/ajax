OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "398237460225172", "52bae937f9009556689643a1d93625a3"
end
