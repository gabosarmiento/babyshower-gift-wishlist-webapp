class ConvidadosController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
   @fiesta = Fiesta.find(params[:fiesta_id])
   @convidado = @fiesta.convidados.create(convidado_params) # Añadir un nuevo Convidado
   @convidado.anfitrion_id = @fiesta.user_id # asignar anfitrion como el usuario actual
   authorize @convidado
   if @convidado.save
    if @convidado.invitado != nil
       ConvidadoMailer.usuario_existente_convidado(@convidado).deliver
       @convidado.invitado.fiestas.push(@convidado.fiesta)
    else
      ConvidadoMailer.nuevo_usuario_convidado(@convidado, new_user_registration_url(:convidado_token => @convidado.token)).deliver #enviar la invitación a nuestro mailer para que entregue el mailer
    end
      redirect_to fiesta_path(@fiesta), notice: "Invitación enviada exitosamente."
   else
      flash[:error] = "Hubo en error enviando la invitación. Intenta nuevamente"
      render :new
   end
  end

  def update
  end

  def destroy
  end

  private
  def convidado_params
    params.require(:convidado).permit(:email)
  end
end
