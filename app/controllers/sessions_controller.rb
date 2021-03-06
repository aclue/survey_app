class SessionsController < ApplicationController
  
  # Handles initial signin
  def new
  end
  
  # Creates a new login sessions
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # successful session
      # reset any previous session
      reset_session
      
      # user was (1) found and
      # (2) user password was correct
      # redirect to user.show
      sign_in user
      conditional_redirect root_url
    else
      # unsuccessful session
      # either user was not found or password was not correct
      # redirect to signin page
      flash.now[:alert] = 'Invalid email and/or password'
      render 'new'
    end
  end
  
  # Destroys the current login session
  def destroy
    # let the user signout only if the user is signed in
    sign_out if signed_in?
    redirect_to root_url
  end
  
end