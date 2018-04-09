class VipReferencePolicy < ApplicationPolicy
  def show?
    user.is_admin? or record.user_id == user.id or !(record.user.sections-user.sections).empty?
    #puts "#{record.user.sections.map(&:id)}"
    true
  end
end