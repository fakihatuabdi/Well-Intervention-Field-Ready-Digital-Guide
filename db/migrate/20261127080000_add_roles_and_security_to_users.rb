class AddRolesAndSecurityToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :name
      # admin = can edit content and manage users; pengguna = read only
      t.string :role, null: false, default: "pengguna"
      # pending = waiting for admin approval, active, disabled
      t.string :status, null: false, default: "pending"

      # Devise :lockable (lock the account after repeated wrong passwords)
      t.integer :failed_attempts, null: false, default: 0
      t.string :unlock_token
      t.datetime :locked_at

      # Devise :trackable (last sign-in time and IP, for audits)
      t.integer :sign_in_count, null: false, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
    end
    add_index :users, :unlock_token, unique: true
    add_index :users, :role
    add_index :users, :status
  end
end
