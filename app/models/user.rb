class User < ActiveRecord::Base
  has_many :accounts, class_name: UserLinkedAccount
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,  :first_name, :last_name, :hometown, :gender, :bio, :image_url

  # attr_accessible :title, :body

  def self.find_for_oauth(auth)
    social_attributes = { first_name: auth.info.first_name, last_name: auth.info.last_name, image_url: auth.info.image, hometown: auth.extra.raw_info.hometown, bio: auth.extra.raw_info.bio, gender: auth.extra.raw_info.gender}

    if user = UserLinkedAccount.where(provider: auth.provider, uid: auth.uid).first.try(:user)
      user.update_attributes(social_attributes)
    elsif user = User.find_by_email(auth.info.email)
      user.update_attributes(social_attributes)
      user.accounts.create(provider: auth.provider, uid: auth.uid)
    else
      user = User.create(social_attributes.merge!({email: auth.info.email, password: Devise.friendly_token[0,20]}))
      user.accounts.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end

end
