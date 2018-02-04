class SessionsController < Clearance::SessionsController  
  def create
    begin 
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue 
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end
  
  private
  def authenticate(_)
    super(session_params)
  end

  def session_params
    { session: session_params_with_email }
  end

  def session_params_with_email
    params.require(:session).permit(:password).merge(email: user.email)
  end

  def user
    User.where(email: email_or_username).or(User.where(username: email_or_username)).first || Guest.new
  end

  def email_or_username
    params[:session][:email_or_username]
  end
end

