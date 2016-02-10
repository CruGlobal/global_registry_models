## Application Controller
class ApplicationController < ActionController::Base
  before_action :assign_access_token

  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  layout proc { |c| c.request.xhr? ? false : 'application' }

  def signed_in?
    cas_signed_in? && current_user.present?
  end

  def current_user
    email = request.session['cas']['user']
    guid = request.session['cas']['extra_attributes']['theKeyGuid']
    @current_user ||= User.where('users.email = ? OR users.guid = ?',
                                 email,
                                 guid).first if cas_signed_in?
  end

  def set_system_of_user
    @system_of_user = GlobalRegistryModels::System::System.find 'deadbeef-dead-beef-dead-beefdeadbeef'
  rescue RestClient::BadRequest, RuntimeError
    flash.delete(:success)
    flash[:error] = 'Your access token appears to be invalid.'
    redirect_to access_tokens_edit_path
    return false
  end

  private

  def authenticate_user
    # user is signed into cas but they are not signed-in to our app
    if cas_signed_in? && !signed_in?
      redirect_to new_session_path, flash: {
        error: "Sorry, the account #{session['cas'].try(:[], 'user')}
                does not have access to Nebo."
      }
      false
    # user is not signed in to cas or our app, so responding with a 401
    elsif !signed_in?
      # intercept the 401 response and start the cas login redirect process
      head status: 401
      false
    else
      after_successful_authentication
    end
  end

  def cas_signed_in?
    # thekey.me returns an extra guid attribute,
    # this guid is the unique identifier (not the email)
    # we will only [be signed into cas if we can get this guid
    request.session.try(:[], 'cas')
           .try(:[], 'extra_attributes')
           .try(:[], 'theKeyGuid')
           .present?
  end

  def after_successful_authentication
    update_current_user_from_cas_session
    current_user.save if current_user.changed?
  end

  def update_current_user_from_cas_session
    extra_attributes = session['cas']['extra_attributes']
    current_user.assign_attributes(email: session['cas']['user'],
                                   first_name: extra_attributes['firstName'],
                                   last_name: extra_attributes['lastName'],
                                   guid: extra_attributes['theKeyGuid'])
  end

  def assign_access_token
    if cookies[:access_token].present?
      GlobalRegistry.access_token = cookies[:access_token]
    else
      GlobalRegistry.access_token =
        Rails.application.secrets[:global_registry_access_token]
      fail 'No Global Registry access token specified!' unless GlobalRegistry.access_token.present?
    end
  end
end
