class RegalosController < ApplicationController
  def index
    @fiesta = Fiesta.find(params[:fiesta_id])
    @lista = @fiesta.listas.find(params[:lista_id])
    @regalos = @lista.regalos
    authorize @regalos
  end

  def new
    @fiesta = Fiesta.find(params[:fiesta_id])
    @lista = Lista.find(params[:lista_id])
    @regalo = @lista.regalos.new
    authorize @regalo
  end

  def show
    @fiesta = Fiesta.find(params[:fiesta_id])
    @lista = Lista.find(params[:lista_id])
    @regalo = Regalo.find(params[:id])
    authorize @regalo
  end

  def edit
  end

  def update
  end

  def create
    @fiesta = Fiesta.find(params[:fiesta_id])
    @lista = @fiesta.listas.find(params[:lista_id])
    @regalo = @lista.regalos.create(regalo_params)
    if @regalo.save 
      redirect_to fiesta_lista_regalo_path(@fiesta, @lista, @regalo), notice: "El Regalo ha sido guardado exitosamente"
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
