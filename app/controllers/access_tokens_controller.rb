## AccessTokens Controller
class AccessTokensController < BaseController
  def edit
  end

  def update
    cookies[:access_token] = params[:access_token][:token]
    assign_access_token
    if set_system_of_user
      flash[:success] = 'Your access token has been successfully updated.'
      redirect_to root_url
    end
  end
end
