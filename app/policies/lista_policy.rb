class ListaPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
     user.present? && (record.fiesta.users.first == user || user.role?(:admin) || record.fiesta.esta_invitado?(user))
  end

  def create?
    update?
  end
  def update?
    user.present? && (record.fiesta.users.first == user || user.role?(:admin))
  end
end