class CreateLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.integer :book_limits

      t.timestamps
    end
  end
end
