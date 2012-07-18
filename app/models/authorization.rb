class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
  belongs_to :user_provider
  validates :provider, :uid, :presence => true

def self.find_or_create(auth_hash)
  unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    user_provider = UserProvider.create :username => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
    auth = create :user_provider => user_provider, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	auth.user_provider_id = user_provider.id
	auth.save
	user_provider.id
  end
 
  auth
end

end
