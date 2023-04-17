require 'rails_helper'

RSpec.describe FollowBlueprint do
  describe '#render' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:follow) { create(:follow, follower: user2, followed: user1) }
    let(:json) do
      JSON.parse(
        described_class.render(follow),
        symbolize_names: true
      )
    end

    it 'contains the correct keys and values' do
      expect(json).to include(
        follower: include(id: user2.id, name: user2.name),
        followed: include(id: user1.id, name: user1.name)
      )
    end
  end
end