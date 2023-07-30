class Library < ApplicationRecord
	has_many :books

  validates :name, presence: true, uniqueness: true
  validates :book_limits, presence: true, numericality: { greater_than: 0 }
end
