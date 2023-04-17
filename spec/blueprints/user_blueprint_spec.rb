require 'rails_helper'

RSpec.describe UserBlueprint do
  describe '#render' do
    let(:user) { create(:user) }
    let(:json) do
      JSON.parse(
        described_class.render(user),
        symbolize_names: true
      )
    end

    it 'contains the correct keys' do
      expect(json).to include(name: user.name)
    end
  end
end