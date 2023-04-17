class User < ApplicationRecord
  has_many :sleep_logs, dependent: :destroy
  has_many :follower_relationships, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :followed_relationships, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy

  has_many :followers, through: :followed_relationships, source: :follower
  has_many :following, through: :follower_relationships, source: :followed

  validates :name, presence: true
end
