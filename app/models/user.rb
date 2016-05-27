class User < ActiveRecord::Base
  def self.from_omniauth(auth_hash)
    user = find_or_create_by(email: auth_hash['info']['email'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls'][user.provider.capitalize]
    user.uid = auth_hash['uid']
    user.save!
    user
  end
end
