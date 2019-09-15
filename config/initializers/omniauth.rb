#Enables Omniauth middleware for Facebook
Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end