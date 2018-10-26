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
  last  = User.last
  last ? last = last.id : last = 0
  id    = (last + 1).to_s
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

def main_user_set
  main_user = quick_user(0)
  main_user[:email]    = 'user'
  main_user[:password] = 'user'
  User.create(main_user)

  main_merch = quick_user(1)
  main_merch[:email]    = 'merch'
  main_merch[:password] = 'merch'
  User.create(main_merch)

  main_admin = quick_user(2)
  main_admin[:email]    = 'admin'
  main_admin[:password] = 'admin'
  User.create(main_admin)
end

main_user_set
user  = User.create(quick_user(0))
merch = User.create(quick_user(1))
admin = User.create(quick_user(2))
