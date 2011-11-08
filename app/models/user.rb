class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  attr_accessible :provider, :uid, :name, :email

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] if auth['info']['name'] # Twitter, Google, Yahoo, GitHub
        user.email = auth['info']['email'] if auth['info']['email'] # Google, Yahoo, GitHub
      end
      if auth['extra'] && auth['extra']['user_hash']
        user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name'] # Facebook
        user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email'] # Facebook
      end
    end
  end

end
