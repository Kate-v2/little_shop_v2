# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def quick_user( role = 0)
  types = { 0 => "user", 1 => 'merch', 2 => 'admin' }
  type  = types[role]
  id    = (User.last.id + 1).to_s
  hash = Hash.new
  hash[:email]    = type + id
  hash[:password] = type + id
  hash[:name]     = type + id
  hash[:address]  = type + id
  hash[:city]     = type + id
  hash[:state]    = type + id
  hash[:zip]      = id
  hash[:role]     = role
  hash[:active]   = 1
  return hash
end

user  = User.create(quick_user(0))
merch = User.create(quick_user(1))
admin = User.create(quick_user(2))
