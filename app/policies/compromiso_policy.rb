class CompromisoPolicy < ApplicationPolicy
  def reservar?
    create?
  end

  def comprar?
    create?
  end

  def liberar?
    create?
  end
  
end