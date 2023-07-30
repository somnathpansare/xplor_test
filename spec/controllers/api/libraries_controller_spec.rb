require 'rails_helper'

RSpec.describe Api::LibrariesController, type: :controller do
  describe "GET #books" do
    let(:library) { FactoryBot.create(:library) }

    context "with valid library id" do
      it "returns information about books in the library" do
        book1 = FactoryBot.create(:book, library: library, title: "Book 1")
        book2 = FactoryBot.create(:book, library: library, title: "Book 2")
        user = FactoryBot.create(:user, name: "John Doe", email: "somnath@example.com")
        book1.update(status: 'checked_out', checked_out_by_user: user)

        get :books, params: { id: library.id }
        expect(response).to have_http_status(:success)
        body = JSON.parse(response.body)
        books = body['books']
        expect(books.size).to eq(2)
        
        expect(books[1]["id"]).to eq(book1.id)
        expect(books[1]["title"]).to eq("Book 1")
        expect(books[1]["status"]).to eq("checked_out")
        expect(books[1]["checked_out_by"]).to eq("John Doe")

        expect(books[0]["id"]).to eq(book2.id)
        expect(books[0]["title"]).to eq("Book 2")
        expect(books[0]["status"]).to eq("available")
        expect(books[0]["checked_out_by"]).to be_nil
      end
    end

    context "with invalid library id" do
      it "returns not found error" do
        get :books, params: { id: 99999 }

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Library not found")
      end
    end
  end
end
