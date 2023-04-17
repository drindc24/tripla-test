class Api::V1::FollowsController < Api::V1::BaseController
  before_action :validate_follow_ids, only: %i(follow)
  
  def follow
    @follow = Follow.create!(follow_params)

    render json: FollowBlueprint.render(@follow)
  end

  def unfollow
    @follow = Follow.find_by!(follow_params)
    
    head :no_content if @follow.destroy!
  end

  private

  def follow_params
    params.require(:follow).permit(
      %i(follower_id followed_id)
    )
  end

  def validate_follow_ids
    @follower = User.find(follow_params[:follower_id])
    @followed = User.find(follow_params[:followed_id])
  end
end