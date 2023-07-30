class User < ApplicationRecord
  has_one :checked_out_book, class_name: 'Book', foreign_key: 'checked_out_by_user_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
