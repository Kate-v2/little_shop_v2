class SessionsController <ApplicationController

  def new
    if session[:user_id]
      flash[:login] = "You are already logged in."

      redirect_to profile_path
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.active && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:login] = "Welcome, #{user.name}!"
      redirect_to profile_path
    elsif !user.active
      flash[:error]= "Your account has been disabled. Please contact your administrator for details."
      render :new
    else
      flash[:login] = "Incorrect email/password combination."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
