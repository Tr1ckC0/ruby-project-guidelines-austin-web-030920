require_relative 'access_db'

#### TESTS #######
# seed_database_with_cards
# 10.times {|i| User.create(username: "#{Faker::FunnyName.name}", password: "Faker::Number.number(digits: 8)")}
# 10.times {|i| Deck.create(name: "#{Faker::Cosmere.shard}", rank: rand(1...10))}


####USER METHODS#########

# def view_cards
#     if self.cards.empty?
#         puts "No cards to display."
#         puts "Please add cards to your collection"
#         ###prompt to add cards
#         ###yes
#     self.cards.each {|card| card.display}
# end