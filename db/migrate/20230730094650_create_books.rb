class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :status, default: 'available'
      t.integer :checked_out_by_user_id
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :books, :users, column: :checked_out_by_user_id
  end
end
