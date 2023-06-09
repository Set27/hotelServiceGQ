# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_422_205_728) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum 'role_enum', %w[ADMIN USER]
  create_enum 'room_class', %w[STANDART DELUXE SUITE]

  create_table 'invoices', force: :cascade do |t|
    t.bigint 'request_id', null: false
    t.integer 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['request_id'], name: 'index_invoices_on_request_id'
  end

  create_table 'requests', force: :cascade do |t|
    t.integer 'price'
    t.integer 'capacity'
    t.bigint 'room_id'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.date 'start_date'
    t.date 'end_date'
    t.index ['room_id'], name: 'index_requests_on_room_id'
    t.index ['user_id'], name: 'index_requests_on_user_id'
  end

  create_table 'rooms', force: :cascade do |t|
    t.string 'title'
    t.integer 'price'
    t.integer 'capacity'
    t.enum 'rating', enum_type: 'room_class'
    t.boolean 'is_occupied', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.enum 'role', enum_type: 'role_enum'
  end

  add_foreign_key 'invoices', 'requests'
  add_foreign_key 'requests', 'rooms'
  add_foreign_key 'requests', 'users'
end
