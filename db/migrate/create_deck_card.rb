class DeckCards < ActiveRecord::Migration[5.0] 
    def change
        create_table :deck_cards do |t|
            t.integer :deck_id 
            t.integer :card_id 
        end
    end
end