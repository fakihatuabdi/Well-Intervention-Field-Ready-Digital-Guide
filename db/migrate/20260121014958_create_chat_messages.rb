class CreateChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_messages do |t|
      t.references :user, null: true, foreign_key: true # Allow anonymous chat
      t.text :message, null: false
      t.string :role, null: false # 'user' or 'assistant'
      t.string :session_id # For anonymous users

      t.timestamps
    end
    add_index :chat_messages, :role
    add_index :chat_messages, :session_id
  end
end
