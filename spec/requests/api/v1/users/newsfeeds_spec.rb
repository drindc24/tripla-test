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
          let(:user3) { create(:user) }

          let(:user_id) { user1.id }

          let!(:sleep_log1) { create(:sleep_log, user: user2, clock_in: '2023-01-03 10:00 PM', clock_out: '2023-01-04 3:00 AM', duration: 5.0) }
          let!(:sleep_log2) { create(:sleep_log, user: user2, clock_in: '2023-01-04 11:00 PM', clock_out: '2023-01-05 3:00 PM', duration: 14.0) }
          let!(:sleep_log3) { create(:sleep_log, user: user1, clock_in: '2023-01-03 11:00 PM', clock_out: '2023-01-04 3:00 AM', duration: 4.0) }
          let!(:sleep_log4) { create(:sleep_log, user: user3, clock_in: '2023-01-03 11:00 PM', clock_out: '2023-01-04 3:00 AM', duration: 4.0) }

          before do
            Timecop.freeze(DateTime.parse('2023-01-15 9:00 AM'))
            create(:follow, follower: user1, followed: user2)
          end

          run_test! do
            expect(response).to have_http_status(:ok)
            expect(json_response).to contain_exactly(
              include(
                id: sleep_log2.id,
                clock_in: '2023-01-04 23:00:00 UTC',
                clock_out: '2023-01-05 15:00:00 UTC',
                duration: '14.0',
                user_id: user2.id
              ),
              include(
                id: sleep_log1.id,
                clock_in: '2023-01-03 22:00:00 UTC',
                clock_out: '2023-01-04 03:00:00 UTC',
                duration: '5.0',
                user_id: user2.id
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