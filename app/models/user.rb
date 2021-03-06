class User < ApplicationRecord
  include Clearance::User
  validates :username, presence: true, uniqueness: true
  has_many :shouts, dependent: :destroy
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  
  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships, 
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followers, through: :follower_relationships
  
  #facebook auth
  def from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.provider = auth_hash['provider']
  end
  #over-ride authentication
  def email_optional?
    true
  end

  def password_optional?
    true
  end
  
  def timeline_shouts
    Shout.where(user_id: followed_user_ids + [id])
  end
  
  def follow(user)
    followed_users << user
  end

  def following?(user)
    followed_users.include?(user)
  end

  def unfollow(user)
    followed_users.delete(user)
  end
  
  def like(shout)
    liked_shouts << shout
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end

  def liked?(shout)
    liked_shout_ids.include?(shout.id)
  end

  def to_param
    username
  end
end
