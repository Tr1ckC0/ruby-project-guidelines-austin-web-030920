class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string  :title
      t.integer :num_of_cards
      t.string  :rank
    end
  end
end
