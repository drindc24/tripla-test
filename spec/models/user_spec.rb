require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:sleep_logs).dependent(:destroy) }
    it { is_expected.to have_many(:follower_relationships).class_name('Follow').dependent(:destroy) }
    it { is_expected.to have_many(:followed_relationships).class_name('Follow').dependent(:destroy) }
    it { is_expected.to have_many(:followers).through(:followed_relationships).source(:follower) }
    it { is_expected.to have_many(:following).through(:follower_relationships).source(:followed) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
