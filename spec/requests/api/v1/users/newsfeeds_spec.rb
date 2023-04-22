require 'swagger_helper'

RSpec.describe 'newsfeeds requests' do
  let(:json_response) do
    JSON.parse(response.body, symbolize_names: true)
  end
  describe '#index' do
    path '/api/v1/users/{user_id}/newsfeeds' do
      get 'retrieve newsfeed for a user' do
        tags 'Newsfeeds'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :string
  
        response '200', 'newsfeed retrieved' do
          let(:user1) { create(:user) }
          let(:user2) { create(:user) }
          let(:user_id) { user1.id }
          let!(:log) { create(:sleep_log, user: user2, clock_in: '2022-01-01 10:00 PM') }

          before do
            create(:follow, follower: user1, followed: user2)
          end

          run_test! do
            expect(response).to have_http_status(:ok)
            expect(json_response).to include(
              id: user1.id,
              name: user1.name,
              newsfeed: contain_exactly(
                include(
                  id: user2.id,
                  name: user2.name,
                  sleep_logs: contain_exactly(
                    id: log.id,
                    user_id: user2.id,
                    clock_in: '2022-01-01 22:00:00 UTC',
                    clock_out: nil,
                    duration: '0.0'
                  )
                )
              )
            )
          end
        end
  
        response '404', 'resource not found' do
          let(:user_id) { 123 }

          run_test! do
            expect(response).to have_http_status(404)
            expect(json_response).to include(
              message: 'Resource not found'
            )
          end
        end
      end
    end
  end
end