class ListaPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
     user.present? && (record.fiesta.users.first == user || user.role?(:admin))
  end

  def update?
    show?
  end
end