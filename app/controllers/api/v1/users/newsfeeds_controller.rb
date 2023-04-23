class Api::V1::Users::NewsfeedsController < Api::V1::BaseController
  before_action :set_user, only: %i(index)
  
  def index
    @logs = @user.following_sleep_logs.where(
      clock_in: last_week.beginning_of_week..last_week.end_of_week
    ).order(duration: :desc)

    render json: SleepLogBlueprint.render(@logs)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def last_week
    DateTime.now.last_week
  end
end