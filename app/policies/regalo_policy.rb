class RegaloPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin)) 
    unless record.empty?
      record.first.lista.fiesta.users.first == user || user.role?(:admin) || record.first.lista.fiesta.esta_invitado?(user)
    end
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