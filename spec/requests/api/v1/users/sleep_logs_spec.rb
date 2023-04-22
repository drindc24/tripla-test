require 'swagger_helper'

RSpec.describe 'sleep logs requests' do
  let(:json_response) do
    JSON.parse(response.body, symbolize_names: true)
  end
  describe '#create' do
    path '/api/v1/users/{user_id}/sleep_logs' do
      post 'create a sleep log for a user' do
        tags 'Sleep Logs'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :string
        parameter name: :sleep_log, in: :body, schema: {
          type: :object,
          properties: {
            sleep_log: { 
              type: :object, schema: {
                user_id: { type: :string },
                clock_in: { type: :string }
              }
            }
          }
        }
  
        response '200', 'sleep log created' do
          let(:user) { create(:user) }
          let(:user_id) { user.id }
          let(:sleep_log) do
            {
              sleep_log: { 
                user_id: user_id,
                clock_in: '2022-01-01 10:00 PM'
              }
            }
          end
  
          run_test! do
            expect(response).to have_http_status(:ok)
            expect(json_response).to include(
              clock_in: '2022-01-01 22:00:00 UTC',
              user_id: user.id
            )
          end
        end
  
        response '404', 'resource not found' do
          let(:user_id) { 123 }
          let(:sleep_log) do
            {
              sleep_log: { user_id: }
            }
          end

          run_test! do
            expect(response).to have_http_status(404)
            expect(json_response).to include(
              message: 'Resource not found'
            )
          end
        end
        
        response '422', 'invalid request' do
          let(:user) { create(:user) }
          let(:user_id) { user.id }
          let(:sleep_log) do
            {
              sleep_log: { user_id: user.id }
            }
          end

          run_test! do
            expect(response).to have_http_status(422)
            expect(json_response).to include(
              message: 'Resource invalid'
            )
          end
        end
      end
    end
  end

  describe '#update' do
    path '/api/v1/users/{user_id}/sleep_logs/{id}' do
      put 'update a sleep log' do
        tags 'Sleep logs'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :sleep_log, in: :body, schema: {
          type: :object,
          properties: {
            sleep_log: { 
              type: :object, schema: {
                user_id: { type: :string },
                clock_in: { type: :string },
                clock_out: { type: :string }
              }
            }
          }
        }

        response '200', 'sleep log created' do
          let(:log) { create(:sleep_log, clock_in: '2022-01-01 10:00 PM') }
          let(:user_id) { log.user.id }
          let(:id) { log.id }
          let(:sleep_log) do
            {
              sleep_log: { 
                clock_out: '2022-01-02 10:00 AM'
              }
            }
          end
  
          run_test! do
            expect(response).to have_http_status(:ok)
            expect(json_response).to include(
              clock_in: '2022-01-01 22:00:00 UTC',
              clock_out: '2022-01-02 10:00:00 UTC',
              duration: '12.0',
              id: log.id,
              user_id: log.user.id,
            )
          end
        end
      end
    end
  end
end