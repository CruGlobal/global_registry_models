## Sessions Controller
class SessionsController < ApplicationController
  def new
    redirect_to root_path if signed_in?
  end

  def create
    # The root path requires authentication, so redirecting
    # there will start the authentication process
    redirect_to root_path
  end

  def destroy
    # rack-cas will intercept the request to '/logout'
    # and perform the CAS logout
    redirect_to '/logout'
  end
end
