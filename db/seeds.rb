# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# u1 = User.find_or_create_by(name: "Jeremiah Example", email: "jeremiah@example.com", password: "jeremiah")
# u2 = User.find_or_create_by(name: "Rodden Example", email: "rodden@example.com", password: "rodden")

barn = Location.find_or_create_by(name: "Barn", user_id: User.first.id)
shed = Location.find_or_create_by(name: "shed", user_id: User.first.id)
cabin = Location.find_or_create_by(name: "cabin", user_id: User.second.id)
lodge = Location.find_or_create_by(name: "lodge", user_id: User.second.id)

blankets = Item.find_or_create_by(name: "Blankets")
firewood = Item.find_or_create_by(name: "firewood")
shovel = Item.find_or_create_by(name: "shovel")

lodge.items << blankets
cabin.items << blankets
barn.items << firewood
shed.items << firewood
shed.items << shovel

# cabin.add_or_update_item_quantity(blankets, 4)
# lodge.add_or_update_item_quantity(blankets, 10)
# barn.add_or_update_item_quantity(firewood, 12)
# shed.add_or_update_item_quantity(firewood, 6)




