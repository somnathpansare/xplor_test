# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

# Create Libraries
library1 = Library.create(name: 'Central Library', book_limits: 10)

# Create Users
user1 = User.create(name: 'John Doe', email: 'john@example.com')
user2 = User.create(name: 'Jane Smith', email: 'jane@example.com')

# Create Books
book1 = Book.create(title: 'Book 1', author: 'Author 1', library: library1)
book2 = Book.create(title: 'Book 2', author: 'Author 2', library: library1)
book3 = Book.create(title: 'Book 3', author: 'Author 3', library: library1)

# Assign books to libraries
library1.books << book1
library1.books << book2
library1.books << book3

# Simulate Checkout
book1.update(status: 'checked_out', checked_out_by_user: user1)
book3.update(status: 'checked_out', checked_out_by_user: user2)
