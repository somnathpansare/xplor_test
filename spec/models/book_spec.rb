require 'rails_helper'

RSpec.describe Book, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      book = FactoryBot.build(:book)
      expect(book).to be_valid
    end

    it "is not valid without a title" do
      book = FactoryBot.build(:book, title: nil)
      expect(book).not_to be_valid
    end

    it "is not valid without a status" do
      book = FactoryBot.build(:book, status: nil)
      expect(book).not_to be_valid
    end

    it "is not valid with an invalid status" do
      book = FactoryBot.build(:book, status: "invalid_status")
      expect(book).not_to be_valid
    end

    it "validates checked_out user presence on update" do
      user = FactoryBot.create(:user)
      book = FactoryBot.create(:book)

      # Try to update the book to checked_out status without a user
      book.update(status: 'checked_out')
      expect(book.errors[:checked_out_by_user_id]).to include("must be present when checking out the book.")

      # Update the book to checked_out status with a user
      book.update(status: 'checked_out', checked_out_by_user: user)
      expect(book).to be_valid
    end

    it "validates library books limit on create" do
      library = FactoryBot.create(:library, book_limits: 2)

      # Create 2 books, which should be allowed
      FactoryBot.create_list(:book, 2, library: library)

      # Try to create one more book, which should not be allowed
      new_book = FactoryBot.build(:book, library: library)
      expect(new_book).not_to be_valid
      expect(new_book.errors[:base]).to include("The library has reached the maximum number of books.")
    end
  end

  context "associations" do
    it "belongs to a library" do
      library = FactoryBot.create(:library)
      book = FactoryBot.create(:book, library: library)

      expect(book.library).to eq(library)
    end

    it "belongs to a user when checked out" do
      user = FactoryBot.create(:user)
      book = FactoryBot.create(:book)
      book.update(status: 'checked_out', checked_out_by_user: user)

      expect(book.checked_out_by_user).to eq(user)
    end
  end
end
