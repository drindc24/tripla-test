require 'rails_helper'

RSpec.describe SleepLogBlueprint do
  describe '#render' do
    let(:log) { create(:sleep_log) }
    let(:json) do
      JSON.parse(
        described_class.render(log),
        symbolize_names: true
      )
    end

    it 'contains the correct keys' do
      expect(json).to include(
        user: include(name: log.user.name),
        clock_in: log.clock_in
      )
    end
  end
end