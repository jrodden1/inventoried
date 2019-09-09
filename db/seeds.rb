# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u1 = User.create(name: "Jeremiah Example", email: "jeremiah@example.com", password: "jeremiah")
u2 = User.create(name: "Rodden Example", email: "rodden@example.com", password: "rodden")

barn = Location.create(name: "Barn", user_id: u1.id)
shed = Location.create(name: "shed", user_id: u1.id)
cabin = Location.create(name: "cabin", user_id: u2.id)
lodge = Location.create(name: "lodge", user_id: u2.id)

blankets = Item.create(name: "Blankets")
firewood = Item.create(name: "firewood")
shovel = Item.create(name: "shovel")

lodge.items << blankets
cabin.items << blankets
barn.items << firewood
shed.items << firewood
shed.items << shovel

