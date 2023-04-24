# frozen_string_literal: true

# rooms
Room.create(title: 'sdasd', price: 123, capacity: 3, rating: 'STANDART')
# users
User.create(name: 'usertest', email: 'user@user.com', password: 'user@user.com', role: 'USER')
User.create(name: 'admintest', email: 'admin@admin.com', password: 'admin@admin.com', role: 'ADMIN')
# requests
Request.create(price: 123, capacity: 3, user_id: 1, start_date: Date.today, end_date: Date.tomorrow)
Request.create(price: 500, capacity: 2, user_id: 1, start_date: Date.today, end_date: Date.tomorrow + 3)
Request.create(price: 40, capacity: 1, user_id: 1, start_date: Date.today, end_date: Date.tomorrow + 10)
# invoices
Invoice.create(request_id: 1)
