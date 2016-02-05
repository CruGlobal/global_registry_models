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

  private

    def save_system
      params[:system][:trusted_ips] = params[:system][:trusted_ips].split(", ") if params[:system][:trusted_ips]
      begin
        system_class.update(params[:id], systems_params) if params[:id]
        system_class.create(systems_params) unless params[:id]
      rescue RestClient::BadRequest
        flash[:error] = 'An error has occured'
      else
        flash[:success] = 'System was successfully updated.'
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
      @current_system = GlobalRegistryModels::System::System.find "deadbeef-dead-beef-dead-beefdeadbeef"
    end

    def systems_params
      params.require(:system).permit(:name, :contact_name, :contact_email, :permalink)
    end
end
