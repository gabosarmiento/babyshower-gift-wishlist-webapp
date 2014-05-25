class FiestasController < ApplicationController
  def index
    @fiestas = current_user.fiestas
    @fiesta = Fiesta.new
    authorize @fiestas
  end

  def new
    @fiesta = Fiesta.new
    authorize @fiesta 
  end

  def edit
    @fiesta = Fiesta.find(params[:id])
    @convidado = @fiesta.convidados.new
    authorize @fiesta
  end

  def create
    @fiesta = current_user.fiestas.create(fiesta_params)
    authorize @fiesta
    if @fiesta.save
      redirect_to @fiesta, notice: "Fiesta creada exitosamente. Ahora añade una lista de regalos"
    else
      flash[:error] = "Tu fiesta no pudo ser creada"
      render :new
    end
  end

  def show
    @fiesta = Fiesta.find(params[:id])
    @lista = @fiesta.listas.first if @fiesta.listas.first
    authorize @fiesta
  end

  def update
    @fiesta = Fiesta.find(params[:id])
    authorize @fiesta
    if @fiesta.update_attributes(fiesta_params)
      redirect_to fiesta_path(@fiesta), notice: "Fiesta fue guardada exitosamente."
    else
      flash[:error] = "Error al actualizar la fiesta. Intenta de nuevo."
      render :edit
    end
  end

  def destroy
    @fiesta = Fiesta.find(params[:id])
    name = @fiesta.nombre
    authorize @fiesta
    if @fiesta.destroy
      flash[:notice] = "\"#{name}\" fue eliminada exitosamente."
      redirect_to fiestas_path
    else
      flash[:error] = "Hubo un error al borrar la fiesta."
      render :show
    end
  end

  def invitaciones
     @invitaciones_ids = current_user.invitaciones.pluck(:fiesta_id)
  end
  private
  def fiesta_params
    params.require(:fiesta).permit(:nombre, :descripcion, :fecha_y_hora_inicio, :fecha_y_hora_cierre, :lugar, :email_contacto, :telefono_contacto)
  end
end
