class User < ActiveRecord::Base
  rolify :role_cname => 'RoleType'
  has_and_belongs_to_many :role_types, :join_table => :users_role_types

  accepts_nested_attributes_for :role_types
  #validates_presence_of :role_types

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
      devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable,
              :registerable #, :confirmable
 end
