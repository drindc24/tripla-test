class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id

  validate :validate_ids

  private

  def validate_ids
    errors.add(:follower_id, 'You cannot follow yourself') if follower_id == followed_id
  end
end
