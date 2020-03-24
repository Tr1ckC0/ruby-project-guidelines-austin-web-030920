require_relative '../config/environment'

##### TESTS #######
10.times {User.new(name: "#{Faker::Name.name}", password: Faker::Number.number(digits: 8))}
10.times {Card.new(name: "#{Faker::FunnyName.name}", password: Faker::Number.number(digits: 8))}
10.times {Deck.new(name: "#{Faker::Name.name}", password: Faker::Number.number(digits: 8))}
