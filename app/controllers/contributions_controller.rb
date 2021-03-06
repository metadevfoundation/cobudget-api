class ContributionsController < ApplicationController
  api :POST, '/contributions', 'Create new contribution'
  def create
    contribution = Contribution.new(contribution_params_create)
    contribution.user = current_user
    authorize contribution
    contribution.save
    respond_with contribution
  end

  api :PUT, '/contributions/:contribution_id', 'Update contribution'
  def update
    update_resource contribution_params_update
  end

  api :DELETE, '/contributions/:contribution_id', 'Deletes contribution'
  def destroy
    destroy_resource
  end

  private
    def contribution_params_create
      params.require(:contribution).permit(:bucket_id, :amount)
    end

    def contribution_params_update
      params.require(:contribution).permit(:amount)
    end
end
