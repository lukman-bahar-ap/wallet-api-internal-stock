class CreateTeams < ActiveRecord::Migration[6.1]
  def up
    create_table :teams do |t|
      t.string :team_name, limit: 50, null: false
      t.string :email, limit: 100, null: false
      t.timestamps
    end

    add_index :teams, :email, unique: true
    add_index :teams, :team_name, unique: true
  end

  def down
    remove_index :teams, :email
    remove_index :teams, :team_name
    drop_table :users
  end
end
  