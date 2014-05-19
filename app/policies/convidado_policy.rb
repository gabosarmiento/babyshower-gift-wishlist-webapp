class ConvidadoPolicy < ApplicationPolicy
  def index?
    true
  end
  def update?
    user.present? && (record.fiesta.user == user || user.role?(:admin))
  end
end