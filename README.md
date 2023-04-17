# README

Notes for API

* Ruby version - 3.2.2
* Rails version - 7.0.4.3
# Gems used
- RSpec for unit testing
- FactoryBot for fixtures
- Blueprint for JSON serialization
- RSwag for API documentation

# Features
- API documentation can be found in **/api-docs/index.html**
- Creating sleep logs
    - `POST /api/v1/users/{user_id}/sleep_logs`
- Follow a user
    - `POST /api/v1/follows/follow`
    - Pass `{ follower_id: 1, followed_id: 2 }` as body params
- Unfollow a user
    - `DELETE /api/v1/follows/unfollow`
    - Pass `{ follower_id: 1, followed_id: 2 }` as body params
- Newsfeeds (followed users' sleep logs)
    - `GET /api/v1/users/{user_id}/newsfeeds`
