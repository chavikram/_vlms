class SessionsController < Devise::SessionsController
  def create
    logger.info "Attempt to sign in by #{ params[:user][:email] }"
    @user = User.find_by_email(params[:user][:email])
    if @user == nil
      
        flash[:notice] = "#{ params[:user][:email]} do not have portal access."
        flash[:notice] = "#{ params[:user][:salt_value]} #{session[:salt]} "
        redirect_to :path=>'vip_ref_app#homescreen'
      else
        super
      end
    
  end
  def new
    session[:salt]='256'
    super
  end
  def destroy
    logger.info "#{ current_user.email } signed out"
    super
  end    
end