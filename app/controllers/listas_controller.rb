class ListasController < ApplicationController
  def index
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @listas = current_user.listas
    authorize @listas
  end

  def show
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = Lista.friendly.find(params[:id])
    authorize @lista
    if request.path != fiesta_lista_path(@fiesta, @lista)
      redirect_to [@fiesta,@lista], status: :moved_permanently
    end
    @disponibles = Regalo.where(lista_id: @lista.id).joins(:compromiso).merge(Compromiso.where(value: "disponible")).order("position")
    @reservados = Regalo.where(lista_id: @lista.id).joins(:compromiso).merge(Compromiso.where(value: "reservado")).order("position")
    @comprados =Regalo.where(lista_id: @lista.id).joins(:compromiso).merge(Compromiso.where(value: "comprado")).order("position")
  end

  def new
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = @fiesta.listas.new
    authorize @lista
  end

  def edit
    @lista = Lista.friendly.find(params[:id])
    authorize @lista
  end

  def update
    @lista = Lista.friendly.find(params[:id])
    @fiesta = @lista.fiesta
    authorize @lista
    if @lista.update_attributes(lista_params)
      redirect_to @fiesta, notice: "Lista guardada exitosamente."
    else
      flash[:error] = "Error al guardar la lista. Intenta de nuevo"
      render :edit 
    end
  end

  def create
    @fiesta = Fiesta.friendly.find(params[:fiesta_id])
    @lista = @fiesta.listas.create(lista_params)
    authorize @lista
    if @lista.save
      redirect_to [@fiesta,@lista], notice: "Lista guardada exitosamente"
    else
      flash[:error] = "Error al crear la lista. Intenta de nuevo"
      render :new
    end 
  end

  def destroy
    @lista = Lista.friendly.find(params[:id])
    @fiesta = @lista.fiesta
    nombre = @lista.nombre
    authorize @lista
    if @lista.destroy
      flash[:notice] = "Lista #{nombre} borrada."
      redirect_to @fiesta
   else
      flash[:error] = "Error al borrar la lista. Inténtalo de nuevo."
      redirect_to @fiesta
    end
  end

  private
  def lista_params
    params.require(:lista).permit(:nombre, :slug)
  end
end
