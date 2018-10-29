class Admin::UsersController <UsersController

  before_action :require_admin

  def index
    @users = User.all
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have successfully updated your info"
      redirect_to profile_path
    else
      flash[:notice] = "Please double check your info and try again"
      redirect_back(fallback_location: root_path)
    end
  end


  private

  def require_admin
    render file: "public/404" unless current_admin?
  end

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
