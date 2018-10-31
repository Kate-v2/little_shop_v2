class SessionsController <ApplicationController

  def new
    if session[:user_id]
      flash[:login] = "You are already logged in."

      redirect_to profile_path
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])

      if user.active
        session[:user_id] = user.id
        flash[:login] = "Welcome, #{user.name}!"
        redirect_to profile_path
      else
        flash[:error]= "Your account has been disabled. Please contact your administrator for details."
        render :new
      end

    else
      flash[:login] = "Incorrect email/password combination."
      render :new
    end
  end

  def destroy
    session[:cart]    = nil
    session[:user_id] = nil
    redirect_to root_path
  end

end
