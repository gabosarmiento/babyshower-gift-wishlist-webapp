class FiestasController < ApplicationController
  def index
  end

  def new
  end

  def edit
    @fiesta = Fiesta.find(params[:id])
    @convidado = @fiesta.convidados.new
    authorize @fiesta
  end

  def create
  end

  def show
    @fiesta = Fiesta.find(params[:id])
    authorize @fiesta
  end

  def update
  end

  def destroy
  end

  private
end
