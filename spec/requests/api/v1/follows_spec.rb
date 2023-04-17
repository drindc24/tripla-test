require 'swagger_helper'

RSpec.describe 'follows requests' do
  let(:json_response) do
    JSON.parse(response.body, symbolize_names: true)
  end

  describe '#follow' do
    path '/api/v1/follows/follow' do
      post 'follow a user' do
        tags 'Follows'
        consumes 'application/json'
        parameter name: :follow, in: :body, schema: {
          type: :object,
          properties: {
            follow: { 
              type: :object, schema: {
                follower_id: { type: :string },
                followed_id: { type: :string }
              }
            }
          }
        }
  
        response '200', 'follow successful' do
          let(:user1) { create(:user) }
          let(:user2) { create(:user) }
          let(:follow) do
            {
              follow: { 
                follower_id: user2.id,
                followed_id: user1.id
              }
            }
          end
  
          run_test! do
            expect(response).to have_http_status(:ok)
            expect(json_response).to include(
              follower: include(id: user2.id, name: user2.name),
              followed: include(id: user1.id, name: user1.name),
            )
          end
        end
  
        response '404', 'resource not found' do
          let(:follow) do
            {
              follow: { 
                follower_id: '123',
                followed_id: '456'
              }
            }
          end

          run_test! do
            expect(response).to have_http_status(404)
            expect(json_response).to include(
              message: 'Resource not found'
            )
          end
        end
        
        response '422', 'invalid request: cannot follow yourself' do
          let(:user) { create(:user) }
          let(:user_id) { user.id }
          let(:follow) do
            {
              follow: { 
                follower_id: user.id,
                followed_id: user.id,
              }
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

  describe '#unfollow' do
    path '/api/v1/follows/unfollow' do
      delete 'follow a user' do
        tags 'Follows'
        consumes 'application/json'
        parameter name: :follow, in: :body, schema: {
          type: :object,
          properties: {
            follow: { 
              type: :object, schema: {
                follower_id: { type: :string },
                followed_id: { type: :string }
              }
            }
          }
        }
  
        response '204', 'unfollow successful' do
          let(:user1) { create(:user) }
          let(:user2) { create(:user) }
          let(:follow) do
            {
              follow: {
                follower_id: user1.id,
                followed_id: user2.id
              }
            }
          end

          before do
            create(:follow, follower: user1, followed: user2)
          end
  
          run_test! do
            expect(response).to have_http_status(:no_content)
          end
        end
  
        response '404', 'resource not found' do
          let(:follow) do
            {
              follow: { 
                follower_id: '123',
                followed_id: '456'
              }
            }
          end

          run_test! do
            expect(response).to have_http_status(404)
            expect(json_response).to include(
              message: 'Resource not found'
            )
          end
        end
        
        response '422', 'invalid request: cannot follow yourself' do
          let(:user1) { create(:user) }
          let(:user2) { create(:user) }
          let(:follow) do
            {
              follow: { 
                follower_id: user1.id,
                followed_id: user2.id,
              }
            }
          end

          before do
            create(:follow, follower: user1, followed: user2)
            allow_any_instance_of(Follow).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed)
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
end