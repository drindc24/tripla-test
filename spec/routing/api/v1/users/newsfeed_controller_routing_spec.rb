# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Newsfeed routing spec', type: :routing do
  describe '#index' do
    it 'routes to the correct controller action' do
      expect(get('/api/v1/users/1/newsfeeds')).to route_to(
        controller: 'api/v1/users/newsfeeds',
        user_id: '1',
        action: 'index'
      )
    end
  end
end