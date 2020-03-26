class Card < ActiveRecord::Base
    has_many :deck_cards
    has_many :user_cards
    has_many :decks, through: :deck_cards
    has_many :users, through: :user_cards


    def display
        puts "------------------------------------------------------------------------------------------------------------"
        puts "NAME              -    #{self.name}"
        puts "                                                                                                      ID: #{self.id}"
        puts "MANA COST         -    #{self.mana_cost}"
        puts "TOTAL MANA COST   -    #{self.total_mana_cost}"
        puts "COLOR             -    #{self.color}"
        puts "MANA TYPES        -    #{self.mana_type}"
        puts "TYPES             -    #{self.types}"
        puts "SUBTYPES          -    #{self.subtypes}"
        puts "RARITY            -    #{self.rarity}"
        puts "SET               -    #{self.set}"
        puts "POWER             -    #{self.power}"
        puts "TOUGHNESS         -    #{self.toughness}"
        puts "************************************************************************************************************"
        puts self.text
        puts "************************************************************************************************************"
        puts ""
        puts "LEGALITY          -    #{self.legality}"
        puts "VIEW IMAGE        -    #{self.imageURL}"
    end

    def display_by_name_and_id
        puts '*' * 100
        puts "#{self.name}" | ID {self.id}
        puts '*' * 100
    end
end