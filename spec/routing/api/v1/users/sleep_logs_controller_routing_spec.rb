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

  describe '#update' do
    it 'routes to the correct controller action' do
      expect(put('/api/v1/users/1/sleep_logs/2')).to route_to(
        controller: 'api/v1/users/sleep_logs',
        id: '2',
        user_id: '1',
        action: 'update'
      )
    end
  end
end