# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Sleep logs routes routing spec', type: :routing do
  describe '#create' do
    it 'routes to the correct controller action' do
      expect(post('/api/v1/users/1/sleep_logs')).to route_to(
        controller: 'api/v1/users/sleep_logs',
        user_id: '1',
        action: 'create'
      )
    end
  end
end