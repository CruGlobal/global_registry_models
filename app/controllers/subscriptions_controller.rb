class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.all
  end

  def new
    @subscription = Subscription.new
    @entity_types = GlobalRegistryModels::EntityType::EntityType.search(page: 1, per_page: 100).order(:name)
  end

  def edit
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      flash[:success] = 'Subscription was successfully added.'
      redirect_to subscriptions_url
    else
      render :new 
    end
  end

  def destroy
    @subscription.destroy
    flash[:success] = 'Subscription was successfully removed.'
    redirect_to subscriptions_url
  end

  private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(:entity_type_id)
    end
end
