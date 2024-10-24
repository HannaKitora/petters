class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  def index
    guest_user.id = User.guest
  end

  private
    def guest_signed_in
      current_user == @user.guest_user
    end
end
