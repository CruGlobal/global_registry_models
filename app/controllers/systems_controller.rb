## Systems Controller
class SystemsController < BaseController
  before_action :set_system, only: [:show, :edit]
  before_action :set_system_of_user, only: [:index, :show, :new, :edit]
  before_action :update_params, only: [:update, :create]

  def index
    @per_page = 80
    @page = params[:page] ||= 1
    @systems = GlobalRegistryModels::System::System.search(page: @page.to_i , per_page: @per_page).order(:name)
  end

  def show
  end

  def new
    @url = '/systems'
  end

  def edit
    @url = "/systems/#{@system.id}"
    @method = :patch
  end

  def create
    save_system
  end

  def update
    save_system
  end

  def reset_token
    system = GlobalRegistryModels::System::System.new id: params[:reset_token][:system_id]
    begin
      updated_system = system.reset_access_token
    rescue RestClient::BadRequest
      flash[:error] = 'An error has occured.'
    else
      flash[:success] =
        "The access token has been resetted to #{updated_system.access_token}."
    end
    redirect_to edit_system_path(params[:reset_token][:system_id])
  end

  private

  def save_system
    try_saving
    redirect_to systems_url
  end

  def try_saving
    system_class.update(params[:id], systems_params) if params[:id]
    system_class.create(systems_params) unless params[:id]
  rescue RestClient::BadRequest, RuntimeError
    flash[:error] = 'An error has occured'
  else
    flash[:success] = 'The system was successfully updated.'
  end

  def system_class
    GlobalRegistryModels::System::System
  end

  def update_params
    if params[:system][:trusted_ips]
      params[:system][:trusted_ips] = params[:system][:trusted_ips].split(', ')
    end
  end

  def set_system
    @system = GlobalRegistryModels::System::System.find params[:id]
  end

  def systems_params
    params.require(:system)
          .permit(:name, :contact_name, :contact_email,
                  :permalink, :root, trusted_ips: [])
  end
end
