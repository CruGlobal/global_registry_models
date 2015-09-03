class UsersController < BaseController

  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, flash: { success: "#{ @user } was created." }
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, flash: { success: "#{ @user } was updated." }
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, flash: { success: "#{ @user } was deleted." }
    else
      redirect_to users_path, flash: { error: "#{ @user } could not be deleted." }
    end
  end

  private

    def user_params
      params.require(:user).permit(:guid, :email, :first_name, :last_name)
    end

end
