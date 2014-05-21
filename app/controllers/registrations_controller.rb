class RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:convidado_token] #<-- saca el valor de la url 
    build_resource({})
    respond_with self.resource
  end

  def create
    @token = params[:convidado_token]

    build_resource(sign_up_params)
    resource.skip_confirmation!
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if @token != nil
        convidado = Convidado.find_by_token(@token)
        org =  convidado.fiesta #encuentra la fiesta atada a la invitación
        # resource.fiestas.push(org) #añade este usuario a la fiesta como rsvp
        resource.invitaciones.push(convidado)
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: fiesta_path(org)
      else
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
        # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
end