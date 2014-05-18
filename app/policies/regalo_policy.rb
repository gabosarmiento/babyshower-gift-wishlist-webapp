class RegaloPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin)) 
    unless record.empty?
      record.first.lista.user == user
    end
  end
  
  def show?
     user.present? && (record.lista.user == user || user.role?(:admin)) 
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end