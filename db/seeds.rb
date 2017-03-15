# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: "Fashion")
Category.create(name: "Car")
Category.create(name: "Travel")
Category.create(name: "Design")
Category.create(name: "Food")
Category.create(name: "Movie")
Category.create(name: "Music")
User.create(first_name: "administrator", email:"administrator@admin.com", password: "admin", is_admin: true)
Post.create(title: "First Post", post: "first post", category_id: 1, user_id: 1)
