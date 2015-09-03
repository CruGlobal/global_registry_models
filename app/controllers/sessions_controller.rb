class SessionsController < ApplicationController

  def new
    redirect_to root_path if signed_in?
  end

  def create
    # The root path requires authentication, so redirecting there will start the authentication process
    redirect_to root_path
  end

end
