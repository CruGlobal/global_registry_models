class AccessTokensController < ApplicationController

  def edit
  end

  def update
    cookies[:access_token] = params[:access_token][:token]
    flash[:success] = "Your access token has been successfully updated."
    redirect_to root_url
  end

end
