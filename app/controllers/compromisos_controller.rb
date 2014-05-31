class CompromisosController < ApplicationController
  before_filter :setup

  def reservar
    actualizar_compromiso("reservado")
    redirect_to :back, notice: "Regalo reservado exitósamente de manera anónima."

  end

  def comprar
    actualizar_compromiso("comprado")
    redirect_to :back, notice: "Regalo comprado exitosamente. Hemos notificado al anfitrión anónimamente."
  end

  def liberar
    actualizar_compromiso("disponible")
    redirect_to :back, notice: "El regalo fue liberado exitosamente."
  end

  def destroy
    if @compromiso.destroy
      redirect_to :back
    else
      redirect_to :back
      flash[:error] = "Hubo un problema al borrarlo."
    end
  end
  private

  def setup
    @lista = Lista.friendly.find(params[:lista_id])
    @regalo = @lista.regalos.find(params[:regalo_id])
    if @regalo.compromiso.nil?
      @compromiso = @regalo.create_compromiso
    else
      @compromiso = @regalo.compromiso
    end
  end

  def actualizar_compromiso(new_value)
      if new_value == "disponible" 
        @compromiso.update_attributes(:value => new_value, :user_id => nil)
      elsif new_value == "comprado" 
        @compromiso.update_attributes(:value => new_value, :user_id => current_user.id)
        CompromisoMailer.nuevo_regalo_comprado(@compromiso).deliver
      else
         @compromiso.update_attributes(:value => new_value, :user_id => current_user.id)
      end
  end
end