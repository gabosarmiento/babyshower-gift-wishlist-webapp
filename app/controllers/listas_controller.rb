class ListasController < ApplicationController
  def index
    @listas = current_user.listas
    authorize @listas
  end

  def show
    @lista = Lista.find(params[:id])
    authorize @lista
  end

  def new
    @lista = current_user.listas.new
    authorize @lista
  end

  def edit
    @lista = Lista.find(params[:id])
    authorize @lista
  end

  def update
    @lista = Lista.find(params[:id])
    authorize @lista
    if @lista.update_attributes(lista_params)
      redirect_to listas_path, notice: "Lista guardada exitosamente."
    else
      flash[:error] = "Error al guardar la lista. Intenta de nuevo"
      render :edit 
    end
  end

  def create
    @lista = current_user.listas.create(lista_params)
    authorize @lista
    if @lista.save
      redirect_to lista_path(@lista), notice: "Lista guardada exitosamente"
    else
      flash[:error] = "Error al crear la lista. Intenta de nuevo"
      render :new
    end 
  end

  def destroy
    @lista = Lista.find(params[:id])
    nombre = @lista.nombre
    authorize @lista
    if @lista.destroy
      flash[:notice] = "Lista #{nombre} borrada."
      redirect_to listas_path
   else
      flash[:error] = "Error al borrar la lista. Inténtalo de nuevo."
      redirect_to listas_path
    end
  end

  private
  def lista_params
    params.require(:lista).permit(:nombre)
  end
end
