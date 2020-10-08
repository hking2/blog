class DigestUserPassword < ActiveRecord::Migration[6.0]
  def change
    # documentation @ "rails has_secure_password API"
    add_column :users, :password_digest, :string
  end
end
