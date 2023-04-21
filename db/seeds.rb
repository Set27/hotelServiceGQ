# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Room.create(title: 'sdasd', price: 123, capacity: 3, rating: 'STANDART')
User.create(name: "usertest", email: "user@user.com", password: "user@user.com", role: "USER")
User.create(name: "admintest", email: "admin@admin.com", password: "admin@admin.com", role: "ADMIN")
Request.create(price: 123, capacity: 3, user_id: 1)
Request.create(price: 500, capacity: 2, user_id: 1)
Request.create(price: 40, capacity: 1, user_id: 1)