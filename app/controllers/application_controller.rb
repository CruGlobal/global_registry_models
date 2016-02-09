class ApplicationController < ActionController::Base
  before_action :assign_access_token
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  layout proc{|c| c.request.xhr? ? false : "application" }

  def signed_in?
    cas_signed_in? && current_user.present?
  end

  def current_user
    cas_request = request.session['cas']
    @current_user ||= User.where("users.email = ? OR users.guid = ?", cas_request['user'], cas_request['extra_attributes']['theKeyGuid']).first if cas_signed_in?
  end

  private

    def authenticate_user
      if cas_signed_in? && !signed_in? # user is signed into cas but they are not signed-in to our app
        redirect_to new_session_path, flash: { error: "Sorry, the account #{ session['cas'].try(:[], 'user') } does not have access to Nebo." }
        false
      elsif !signed_in? # user is not signed in to cas or our app, so start the cas authenticate process by responding 401
        head status: 401 # rack-cas will intercept the 401 response and start the cas login redirect process
        false
      else
        after_successful_authentication
      end
    end

    def cas_signed_in?
      # thekey.me returns an extra guid attribute, this guid is the unique identifier (not the email)
      # we will only [be signed into cas if we can get this guid
            request.session.try(:[], 'cas').try(:[], 'extra_attributes').try(:[], 'theKeyGuid').present?
    end

    def after_successful_authentication
      update_current_user_from_cas_session
    end

    def update_current_user_from_cas_session
      current_user.assign_attributes(email: session['cas']['user'],
                                     first_name: session['cas']['extra_attributes']['firstName'],
                                     last_name: session['cas']['extra_attributes']['lastName'],
                                     guid: session['cas']['extra_attributes']['theKeyGuid'])
      current_user.save if current_user.changed?
    end

    def assign_access_token
      if cookies[:access_token].present?
        GlobalRegistry.access_token = cookies[:access_token] 
      else
        GlobalRegistry.access_token = Rails.application.secrets[:global_registry_access_token] 
        raise 'No Global Registry access token specified!' unless GlobalRegistry.access_token.present?
      end
    end

end
