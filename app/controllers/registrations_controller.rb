class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)
    #resource.role = "user"

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up  if is_navigational_format?
        sign_in_and_redirect(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
        expire_session_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      #render_with_scope :new #devise no longer support this
      render :new
    end
  end

  def token
    #@user = User.where(:id => params[:user_id]).first
    #@user.reset_authentication_token!
    redirect_to edit_user_registration_path(@user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_registration
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registration_params
    params.require(:user).permit(:name,
                                 :email, :password, :password_confirmation, :role)
  end
end
