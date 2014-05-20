class RegaloPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin)) 
    unless record.empty?
      record.first.lista.fiesta.users.first == user
    end
  end
  
  def show?
     user.present? && (record.lista.fiesta.users.first == user || user.role?(:admin)) 
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end