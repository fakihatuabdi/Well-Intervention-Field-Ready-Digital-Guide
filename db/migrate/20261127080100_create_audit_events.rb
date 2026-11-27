class CreateAuditEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :audit_events do |t|
      t.references :user, foreign_key: { on_delete: :nullify }
      t.string :actor_email
      t.string :action, null: false
      t.string :target_type
      t.bigint :target_id
      t.string :target_label
      t.text :details
      t.string :ip_address
      t.datetime :created_at, null: false
    end
    add_index :audit_events, :created_at
    add_index :audit_events, [:target_type, :target_id]
  end
end
