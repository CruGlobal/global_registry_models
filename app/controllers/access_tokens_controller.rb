## AccessTokens Controller
class AccessTokensController < BaseController
  def edit
  end

  def update
    if params[:access_token][:token].present?
      cookies[:access_token] = params[:access_token][:token]
      assign_access_token
      if set_system_of_user
        flash[:success] = 'Your access token has been successfully updated.'
      end
    else
      flash[:success] = 'Your access token has been successfully removed.'
    end
    redirect_to root_url if flash[:success]
  end
end
