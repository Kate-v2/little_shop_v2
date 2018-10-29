class UsersController <ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:register] = "You are now registered and logged in"
      redirect_to profile_path
    else
      render :new
    end
  end

  def show
  end


  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
