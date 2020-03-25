class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string  :title
      t.string  :rank
      t.integer :user_id
    end
  end
end