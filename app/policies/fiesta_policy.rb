class FiestaPolicy < ApplicationPolicy
  def index?
    true
  end
  def show?
    user.present? && (record.users.first == user || user.role?(:admin) || record.esta_invitado?(user))
  end

  def create?
    user.present? 
  end

  def update?
    user.present? && (record.users.first == user || user.role?(:admin) )
  end

  def destroy?
    update?
  end
end