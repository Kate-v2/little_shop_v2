class UsersController <ApplicationController

  def index
    @merchants = User.where(role: 'merchant')
    @user = User.find(session[:user_id]) if session[:user_id]
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
    if current_admin?
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
  end

  def update
    if current_admin?
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
    if @user.update(user_params)
      flash[:success] = "You have successfully updated your info"
      if current_admin? && @user.merchant?
        redirect_to merchant_path(@user)
      elsif current_admin?
        redirect_to user_path(@user)
      else
        redirect_to profile_path
      end
    else
      flash[:notice] = "Please double check your info and try again"
      redirect_back(fallback_location: root_path)
    end

  end

  def show
    if request.path == profile_path
      @user = User.find(session[:user_id])
    elsif current_admin?
      @user = User.find(params[:id])
    else
      render file: "public/404"
    end
  end

  def toggle
    user = User.find(params[:user].to_i)
    user.toggle(:active).save
    if user.active
      flash[:success]= "#{user.name.capitalize}'s account has been activated"
    else
      flash[:success]= "#{user.name.capitalize}'s account has been disabled"
    end
    redirect_back(fallback_location: root_path)
  end


  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
