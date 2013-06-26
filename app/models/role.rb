class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def role?(role)
  	return !!self.roles.find_by_name(role.to_s)
  end
end