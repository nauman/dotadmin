class RoleType < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_role_types
  belongs_to :resource, :polymorphic => true
  
  scopify
end
