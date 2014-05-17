class RegalosController < ApplicationController
  def index
    @lista = Lista.find(params[:lista_id])
    @regalos = @lista.regalos
    authorize @regalos
  end

  def new
    @lista = Lista.find(params[:lista_id])
    @regalo = Regalo.new
    authorize @regalo
  end

  def show
    @regalo = Regalo.find(params[:id])
  end

  def edit
  end

  def update
  end

  def create
    @lista = Lista.find(params[:lista_id])
    @regalo = @lista.regalos.create(regalo_params)
    if @regalo.save 
      redirect_to lista_regalos_path(@lista), notice: "El Regalo ha sido guardado exitosamente"
    else
      flash[:error] = "Hubo un error al guardar el regalo. Inténtalo de nuevo"
      render :new
    end
  end

  def destroy
  end
 
  def regalo_params
    params.require(:regalo).permit(:titulo, :imagen, :url, :remote_imagen_url)
  end
end
