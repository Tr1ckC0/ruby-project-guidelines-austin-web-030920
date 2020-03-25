require_relative '../config/environment'

##### TESTS #######
10.times do {|i| Card.new(id: i, name: "#{Faker::Name.name}"}
10.times do {|i| User.new(id: i, name: "#{Faker::Name.name}"}
10.times do {|i| Deck.new(id: i, username: "#{Faker::Name.name}")}
