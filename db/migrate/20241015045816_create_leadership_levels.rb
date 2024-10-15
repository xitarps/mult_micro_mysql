class CreateLeadershipLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :leadership_levels do |t|
      t.integer :level, null: false, default: 0
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :leadership_levels, [:level, :company_id], unique: true
  end
end
