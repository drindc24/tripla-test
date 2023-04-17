require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followed).class_name('User') }
  end

  describe '#custom_validation' do
    let(:user1) { create(:user) }
    let(:follow) { build(:follow, follower: user1, followed: user1) }

    it 'returns an error because a user cannot follow itself' do
      expect(follow).not_to be_valid
      expect(follow.errors[:follower_id]).to include(
        'You cannot follow yourself'
      )
    end
  end
end
