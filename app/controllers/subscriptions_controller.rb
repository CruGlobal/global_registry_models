class SubscriptionsController < ApplicationController
  before_action :get_entity_types, only: [:index, :new]
  
  def index
    @subscriptions = GlobalRegistryModels::Subscription::Subscription.search
  end

  def new

  end

  def create
    begin
      GlobalRegistryModels::Subscription::Subscription.create(subscription_params)
    rescue RestClient::BadRequest
      flash[:error] = 'An error has occured'
    else
      flash[:success] = 'Subscription was successfully added.'
    end
    redirect_to subscriptions_url
  end

  def destroy
    GlobalRegistryModels::Subscription::Subscription.delete params[:id]
    flash[:success] = 'Subscription was successfully removed.'
    redirect_to subscriptions_url
  end

  private

    def get_entity_types
      @entity_types = GlobalRegistryModels::EntityType::EntityType.search(page: 1, per_page: 100).order(:name)
    end

    def subscription_params
      params.require(:subscription).permit(:entity_type_id, :endpoint, :client_integration_id)
    end
end
