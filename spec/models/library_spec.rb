require 'rails_helper'

RSpec.describe Library, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      library = FactoryBot.build(:library)
      expect(library).to be_valid
    end

    it "is not valid without a name" do
      library = FactoryBot.build(:library, name: nil)
      expect(library).not_to be_valid
    end

    it "is not valid with a duplicate name" do
      FactoryBot.create(:library, name: "Duplicate Library")
      library = FactoryBot.build(:library, name: "Duplicate Library")
      expect(library).not_to be_valid
    end

    it "is not valid without book_limits" do
      library = FactoryBot.build(:library, book_limits: nil)
      expect(library).not_to be_valid
    end

    it "is not valid with book_limits less than 1" do
      library = FactoryBot.build(:library, book_limits: 0)
      expect(library).not_to be_valid
    end
  end

  context "associations" do
    it "has many books" do
      library = FactoryBot.create(:library)
      book1 = FactoryBot.create(:book, library: library)
      book2 = FactoryBot.create(:book, library: library)

      expect(library.books).to match_array([book1, book2])
    end
  end
end
