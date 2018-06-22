class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :prototype, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
