class Api::V1::Users::SleepLogsController < Api::V1::BaseController
  before_action :set_user, only: %i(create update)
  
  def create
    @sleep_log = @user.sleep_logs.create!(sleep_log_params)

    render json: SleepLogBlueprint.render(@sleep_log)
  end

  def update
    @sleep_log = @user.sleep_logs.update(sleep_log_params)

    render json: SleepLogBlueprint.render(@sleep_log)
  end
  private

  def sleep_log_params
    params.require(:sleep_log).permit(
      %i(user_id clock_in clock_out)
    )
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end