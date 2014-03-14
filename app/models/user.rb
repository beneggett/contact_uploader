class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :first_name, :last_name, :hometown, :gender, :bio, :image_url
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth)

    facebook_attributes = { provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20], first_name: auth.info.first_name, last_name: auth.info.last_name, image_url: auth.info.image, hometown: auth.extra.raw_info.hometown, bio: auth.extra.raw_info.bio, gender: auth.extra.raw_info.gender}

    if user = User.where(provider: auth.provider, uid: auth.id).first
      user.update_attributes(facebook_attributes)
      user
    elsif user = User.find_by_email(auth.info.email)
      user.update_attributes(facebook_attributes)
      user
    else
      user = User.create(facebook_attributes)
    end
  end
end
