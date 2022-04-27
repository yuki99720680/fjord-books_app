class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :following, null: false, foreign_key: true, unique: true
      t.references :follower, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
