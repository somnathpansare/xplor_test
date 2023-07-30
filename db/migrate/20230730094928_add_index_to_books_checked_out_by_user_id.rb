class AddIndexToBooksCheckedOutByUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :books, :checked_out_by_user_id
  end
end
