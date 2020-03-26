class Deck < ActiveRecord::Base
    belongs_to  :user
    has_many    :deck_cards
    has_many    :cards, through: :deck_cards

    def display
        puts "#{self.title}, #{self.rank}"
    end
end