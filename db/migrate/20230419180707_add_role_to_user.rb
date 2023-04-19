class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    create_enum :role_enum, %w[ADMIN USER]
    add_column :users, :role, :role_enum
  end
end
