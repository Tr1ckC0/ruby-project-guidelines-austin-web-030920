class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string  :name
      t.string  :mana_cost
      t.integer :total_mana_cost
      t.string  :color
      t.string  :mana_type
      t.string  :types
      t.string  :subtypes
      t.string  :rarity
      t.string  :set 
      t.string  :text
      t.integer :power
      t.integer :toughness
      t.string  :legality
      t.string  :imageURL
    end
  end
end
