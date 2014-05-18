class ListaPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
     user.present? && (record.user == user || user.role?(:admin))
  end
end