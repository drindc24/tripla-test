class Api::V1::Users::NewsfeedsController < Api::V1::BaseController
  before_action :set_user, only: %i(index)
  
  def index
    render json: UserBlueprint.render(@user, view: :with_newsfeed)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end