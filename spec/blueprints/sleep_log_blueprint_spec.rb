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

    it 'contains the correct keys and values' do
      expect(json).to include(
        user_id: log.user.id,
        clock_in: log.clock_in,
        clock_out: nil,
        duration: '0.0'
      )
    end
  end
end