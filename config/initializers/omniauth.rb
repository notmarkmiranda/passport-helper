OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	# provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
		callback_path: '/auth/facebook/callback'
end
