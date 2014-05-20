class ConvidadosController < ApplicationController
  def index
    @fiesta = Fiesta.find(params[:fiesta_id])
    @convidados = @fiesta.convidados
    @convidado = Convidado.new
    @convidado.fiesta_id = @fiesta.id
    authorize @convidados
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
   @convidado.anfitrion_id = @fiesta.users.first.id # asignar anfitrion como el usuario actual
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
    @fiesta = Fiesta.find(params[:fiesta_id])
    @convidado = Convidado.find(params[:id])
    if @convidado.destroy
      flash[:notice] = "Eliminado de la lista de convidados"
      redirect_to fiesta_convidados_path(@fiesta)
    else
      redirect_to fiesta_convidados_path(@fiesta)
      flash[:error] = "No se pudo eliminar. Intenta de nuevo."
    end
  end

  private
  def convidado_params
    params.require(:convidado).permit(:email)
  end
end
