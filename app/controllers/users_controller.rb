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

  def edit
   @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:success] = "You have successfully updated your info"
      redirect_to profile_path
    else
      flash[:notice] = "Please double check your info and try again"
      redirect_back(fallback_location: root_path)
    end

  end

  def show
      @user = User.find(session[:user_id])
  end

  def activate

  end


  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
