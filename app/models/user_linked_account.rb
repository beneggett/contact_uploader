class UserLinkedAccount < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid

  validates :uid, uniqueness: true
end
