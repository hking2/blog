class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    #action :table, :column, :type
    add_column :users, :admin, :boolean, default: false
  end
end
