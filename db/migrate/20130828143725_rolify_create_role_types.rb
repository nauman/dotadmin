class RolifyCreateRoleTypes < ActiveRecord::Migration
  def change
    create_table(:role_types) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_role_types, :id => false) do |t|
      t.references :user
      t.references :role_type
    end

    add_index(:role_types, :name)
    add_index(:role_types, [ :name, :resource_type, :resource_id ])
    add_index(:users_role_types, [ :user_id, :role_type_id ])
  end
end
