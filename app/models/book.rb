class Book < ApplicationRecord
  belongs_to :library
  belongs_to :checked_out_by_user, class_name: 'User', foreign_key: 'checked_out_by_user_id', optional: true

  validates :title, presence: true
  validates :author, presence: true
  validates :status, presence: true, inclusion: { in: %w[available checked_out] }
  validate :validate_checked_out_user_presence, on: :update
  validate :check_library_books_limit, on: :create

  def available?
    status == 'available'
  end

  private

  def check_library_books_limit
    return unless library.present?

    if library.books.count >= library.book_limits
      errors.add(:base, "The library has reached the maximum number of books.")
    end
  end

  def validate_checked_out_user_presence
    return if available? || checked_out_by_user.present?

    errors.add(:checked_out_by_user_id, 'must be present when checking out the book.')
  end
end
