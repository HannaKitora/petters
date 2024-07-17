class ApplicationController < ActionController::Base
  
  add_flash_types :success, :info, :warning, :danger
  
  def ensure_login_user
    if @current_user == nil
      # redirect_to root_path, notice: "ログインが必要です"
      flash[:alert] = 'ログインが必要です'
      redirect_to root_path
    end
  end

  # def set_current_user
  #   @current_user=User.find_by(id :session[:user_id])
  # end
  # before_action :configure_authentication

  # private
 
  # def configure_authentication
  #   if admin_controller?
  #     authenticate_admin!
  #   else
  #     authenticate_user! unless action_is_public?
  #   end
  # end
  
  # def admin_controller?
  #   self.class.module_parent_name == 'Admin'
  # end
  
  # def action_is_public?
  #   controller_name == 'homes' && action_name == 'top'
  # end

end
