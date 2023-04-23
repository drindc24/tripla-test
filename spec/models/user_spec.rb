require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:sleep_logs).dependent(:destroy) }
    it { is_expected.to have_many(:follower_relationships).class_name('Follow').dependent(:destroy) }
    it { is_expected.to have_many(:followed_relationships).class_name('Follow').dependent(:destroy) }
    it { is_expected.to have_many(:followers).through(:followed_relationships).source(:follower) }
    it { is_expected.to have_many(:following).through(:follower_relationships).source(:followed) }
    it { is_expected.to have_many(:following_sleep_logs).through(:following).class_name('SleepLog').source(:sleep_logs) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#following_sleep_logs' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    let!(:sleep_log1) { create(:sleep_log, user: user2) }
    let!(:sleep_log2) { create(:sleep_log, user: user2) }
    let!(:sleep_log3) { create(:sleep_log, user: user1) }
    let!(:sleep_log4) { create(:sleep_log, user: user3) }

    before do
      create(:follow, follower: user1, followed: user2)
    end

    it 'returns the followed sleep logs' do
      expect(user1.following_sleep_logs).to contain_exactly(
        sleep_log1, sleep_log2
      )
    end
  end
end
