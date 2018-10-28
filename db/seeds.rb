# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# --- Users ----

def quick_user(role = 0)
  types = { 0 => "user", 1 => 'merch', 2 => 'admin' }
  type  = types[role]
  last  = User.last
  last ? last = last.id : last = 0
  id    = (last + 1).to_s
  hash = Hash.new
  hash[:email]    = type + id
  hash[:password] = type + id
  hash[:name]     = type + id
  hash[:address]  = "Address" + id
  hash[:city]     = "City"    + id
  hash[:state]    = "State"   + id
  hash[:zip]      = id.to_i * 100
  hash[:role]     = role
  hash[:active]   = 1
  return hash
end

def main_user_set
  main_user = quick_user(0)
  main_user[:email]    = 'user'
  main_user[:password] = 'user'
  @user = User.create(main_user)

  main_merch = quick_user(1)
  main_merch[:email]    = 'merch'
  main_merch[:password] = 'merch'
  @merch = User.create(main_merch)

  main_admin = quick_user(2)
  main_admin[:email]    = 'admin'
  main_admin[:password] = 'admin'
  @admin = User.create(main_admin)
end

main_user_set
user2  = User.create(quick_user(0))
user3  = User.create(quick_user(0))
user4  = User.create(quick_user(0))
user5  = User.create(quick_user(0))
user6  = User.create(quick_user(0))

merch2 = User.create(quick_user(1))
merch3 = User.create(quick_user(1))
merch4 = User.create(quick_user(1))
merch5 = User.create(quick_user(1))
merch6 = User.create(quick_user(1))

admin2 = User.create(quick_user(2))


# --- Items ----

def quick_item( options = {seller: nil, image: nil, inventory: 100} )
  last  = Item.last
  last ? last = last.id : last = 0
  id    = (last + 1).to_s
  hash = Hash.new
  hash[:name]        = "Item" + id
  hash[:description] = "Item" + id
  hash[:price]       = id.to_i
  hash[:inventory]   = options[:inventory]
  hash[:user_id]     = options[:seller]
  hash[:image]       = options[:image]
  hash[:active]      = 1
  return hash
end

def make_items(merch, multi, item_hash = nil)
  multi.times { merch.items.create(quick_item) } if !item_hash
  multi.times { merch.items.create(item_hash) }  if  item_hash
end

make_items(@merch, 5)
make_items(merch2, 2)
make_items(merch3, 3)
make_items(merch4, 4)
make_items(merch5, 5)
make_items(merch6, 6)
