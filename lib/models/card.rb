class Card < ActiveRecord::Base
    has_many :deck_cards
    has_many :user_cards
    has_many :decks, through: :deck_cards
    has_many :users, through: :user_cards


    def display
        puts "------------------------------------------------------------------------------------------------------------"
        puts "NAME".bold + "              -    #{self.name}"
        puts "                                                                                                      ID: #{self.id}".blue
        puts "MANA COST".bold + "         -    #{self.mana_cost}"
        puts "TOTAL MANA COST".bold + "   -    #{self.total_mana_cost}"
        puts "COLOR".bold + "             -    #{self.color}"
        puts "MANA TYPES".bold + "        -    #{self.mana_type}"
        puts "TYPES".bold + "            -    #{self.types}"
        puts "SUBTYPES".bold + "          -    #{self.subtypes}"
        puts "RARITY".bold + "            -    #{self.rarity}"
        puts "SET".bold + "               -    #{self.set}"
        puts "POWER".bold + "             -    #{self.power}"
        puts "TOUGHNESS".bold + "         -    #{self.toughness}"
        puts "************************************************************************************************************"
        puts self.text
        puts "************************************************************************************************************"
        puts ""
        puts "LEGALITY          -    #{self.legality}"
        puts "VIEW IMAGE        -    " + "#{self.imageURL}".blue
    end

    def display_by_name_and_id
        puts '-' * 30
        puts "#{self.name} | ID #{self.id}"
    end

    def display_by_color
        puts '-' * 30
        puts "#{self.color.upcase}  |  #{self.name}  |  ID #{self.id}"
    end

    def display_by_rarity
        puts '-' * 30
        puts "#{self.rarity.upcase}  |  #{self.name}  |  ID #{self.id}"
    end
end