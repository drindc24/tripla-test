# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Follows routes routing spec', type: :routing do
  describe '#follow' do
    it 'routes to the correct controller action' do
      expect(post('/api/v1/follows/follow')).to route_to(
        controller: 'api/v1/follows',
        action: 'follow'
      )
    end
  end

  describe '#unfollow' do
    it 'routes to the correct controller action' do
      expect(post('/api/v1/follows/unfollow')).to route_to(
        controller: 'api/v1/follows',
        action: 'unfollow'
      )
    end
  end
end