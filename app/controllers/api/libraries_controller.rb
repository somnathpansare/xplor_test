class Api::LibrariesController < ApplicationController
	
	def books
		library = Library.find_by(id: params[:id])
   
    if library
      render json: { library: library, books: library_books_info(library) }
    else
      render json: { error: "Library not found" }, status: :not_found
    end
  end

  private

  def library_books_info(library)
    library.books.map do |book|
      {
        id: book.id,
        title: book.title,
        status: book_status(book),
        checked_out_by: checked_out_by(book)
      }
    end
  end

  def book_status(book)
    book.available? ? 'available' : 'checked_out'
  end

  def checked_out_by(book)
    book.checked_out_by_user_id.present? ? book.checked_out_by_user.name : nil
  end
end
