class RegaloPolicy < ApplicationPolicy
  def index?
    # en el controlador @lista es el record
     user.present? && (record.fiesta.users.first == user || user.role?(:admin) || record.fiesta.esta_invitado?(user))
  end
  
  def show?
     user.present? && (record.lista.fiesta.users.first == user || user.role?(:admin) || record.lista.fiesta.esta_invitado?(user)) 
  end

  def update?
     user.present? && (record.lista.fiesta.users.first == user || user.role?(:admin)) 
  end

  def destroy?
    show?
  end
end