class TiendasController < ApplicationController
  def index
    @tiendas = Tienda.paginate(:page => params[:page], :per_page => 10)
    @tienda = Tienda.new
    authorize @tienda 
  end

  def new
    @tienda = Tienda.new
    authorize @tienda
  end

  def edit
    @tienda = Tienda.find(params[:id])
    authorize @tienda
  end

  def update
    @tienda = Tienda.find(params[:id])
    authorize @tienda
    if @tienda.update_attributes(tienda_params)
      redirect_to tiendas_path, notice: "Tienda actualizada exitosamente."
    else
      flash[:error] = "Tienda no pudo ser actualizada. Intenta nuevamente."
      render :edit
    end
  end

  def create
    @tienda = Tienda.create(tienda_params)
    authorize @tienda
    if @tienda.save
      redirect_to @tienda, notice: "Tienda creada exitosamente."
    else
      flash[:error] = "Tienda no pudo ser creata. Intenta nuevamente."
      render :new
    end
  end

  def destroy
    @tienda = Tienda.find(params[:id])
    nombre = @tienda.nombre
    authorize @tienda
    if @tienda.destroy
      redirect_to tiendas_path, notice: "Tienda #{nombre} borrada exitosamente."
    else
      flash[:error] = "Tienda #{nombre} no pudo ser borrada."
      redirect_to @tienda
    end
  end

  def show
    @tienda = Tienda.find(params[:id])
    authorize @tienda
  end

  def tienda_params
    params.require(:tienda).permit(:nombre, :url, :acerca_de, :locacion)
  end

end
