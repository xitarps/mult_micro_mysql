class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :level
      t.references :leadership_level, null: true, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
