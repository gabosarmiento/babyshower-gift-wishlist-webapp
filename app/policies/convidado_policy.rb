class ConvidadoPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    update?
  end
  def update?
    user.present? && (record.fiesta.users.first == user || user.role?(:admin))
  end
end