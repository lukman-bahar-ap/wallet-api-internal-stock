class CreateTeamMembers < ActiveRecord::Migration[6.1]
  def up
    create_table :team_members do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :team, null: false, foreign_key: { to_table: :teams }
      t.integer :is_lead, limit: 1, null: false, default: 0
      t.timestamps
    end
  end

  def down
    drop_table :team_members
  end
end
  