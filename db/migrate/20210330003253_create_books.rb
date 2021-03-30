class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.belongs_to :user, null: true, foreign_key: true
      t.integer :state, default: 0

      t.timestamps
    end
  end
end
