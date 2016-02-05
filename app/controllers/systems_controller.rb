class SystemsController < ApplicationController
  before_action :set_system, only: [:show, :edit]
  before_action :set_current_system, only: [:index, :show, :new, :edit]

  def index
    @systems = GlobalRegistryModels::System::System.search
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    save_system
  end

  def update
    save_system
  end

  def reset_token
    system = GlobalRegistryModels::System::System.new id: params[:system_id]
    begin
      updated_system = system.reset_access_token
    rescue RestClient::BadRequest
      flash[:error] = "An error has occured."
    else
      flash[:success] = "The access token has been resetted to #{updated_system.access_token}."
    end
    redirect_to edit_system_path(params[:system_id])
  end

  private

    def save_system
      params[:system][:trusted_ips] = params[:system][:trusted_ips].split(", ") if params[:system][:trusted_ips]
      begin
        system_class.update(params[:id], systems_params) if params[:id]
        system_class.create(systems_params) unless params[:id]
      rescue RestClient::BadRequest
        flash[:error] = 'An error has occured'
      else
        flash[:success] = 'The system was successfully updated.'
      end
      redirect_to systems_url
    end

    def system_class
      GlobalRegistryModels::System::System
    end

    def set_system
      @system = GlobalRegistryModels::System::System.find params[:id]
    end

    def set_current_system
      @system_of_user = GlobalRegistryModels::System::System.find "deadbeef-dead-beef-dead-beefdeadbeef"
    end

    def systems_params
      params.require(:system).permit(:name, :contact_name, :contact_email, :permalink)
    end
end
