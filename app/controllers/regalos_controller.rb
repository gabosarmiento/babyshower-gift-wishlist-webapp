class RegalosController < ApplicationController
  def index
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = @fiesta.listas.friendly.find(params[:lista_id])
    @regalos = @lista.regalos.order("position")
    authorize @regalos
  end

  def new
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = Lista.friendly.find(params[:lista_id])
    @regalo = @lista.regalos.new
    authorize @regalo
  end

  def show
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = Lista.friendly.find(params[:lista_id])
    @regalo = Regalo.find(params[:id])
    authorize @regalo
  end

  def edit
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = Lista.friendly.find(params[:lista_id])
    @regalo = Regalo.find(params[:id])
    authorize @regalo
  end

  def update
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = Lista.friendly.find(params[:lista_id])
    @regalo = Regalo.find(params[:id])
    authorize @regalo
     if @regalo.update_attributes(regalo_params)
      redirect_to fiesta_lista_regalos_path(@fiesta, @lista), notice: "Regalo fue actualizado exitosamente."
    else
      flash[:error] = "Error al actualizar el regalo. Intenta de nuevo."
      render :edit
    end
  end

  def create
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = @fiesta.listas.friendly.find(params[:lista_id])
    @regalo = @lista.regalos.create(regalo_params)
    if @regalo.save 
      redirect_to fiesta_lista_regalo_path(@fiesta, @lista, @regalo), notice: "El Regalo ha sido guardado exitosamente"
    else
      flash[:error] = "Hubo un error al guardar el regalo. Inténtalo de nuevo"
      render :new
    end
  end

  def destroy
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = Lista.friendly.find(params[:lista_id])
    @regalo = Regalo.find(params[:id])
    authorize @regalo
    if @regalo.destroy
      redirect_to fiesta_lista_regalos_path(@fiesta, @lista), notice: "Regalo borrado exitosamente."
    else
       flash[:error] = "Hubo un error al borrar el regalo."
      redirect_to fiesta_lista_regalos_path(@fiesta, @lista)
    end
  end

  def ordenar
    params[:regalo].each_with_index do |id, index|
    Regalo.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def reservados
    @compromisos = current_user.compromisos
  end
  def regalo_params
    params.require(:regalo).permit(:titulo, :descripcion, :imagen, :url, :remote_imagen_url, :donde_lo_consigues, :position)
  end
end
