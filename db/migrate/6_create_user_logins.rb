class CreateUserLogins < ActiveRecord::Migration[6.1]
    def up
      create_table :user_logins do |t|
        t.references :loginable, polymorphic: true, null: false, limit: 25 # Polymorphic association
        t.string :username, limit: 100, null: false
        t.string :password_digest, limit: 60, null: false
        t.string :session_token
        t.timestamps
      end
  
      add_index :user_logins, [:loginable_type, :loginable_id] # Index on polymorphic reference
      add_index :user_logins, :username, unique: true
    end

    def down
      remove_index :user_logins, [:loginable_type, :loginable_id]
      remove_index :user_logins, :username
      drop_table :user_logins
    end
end
  