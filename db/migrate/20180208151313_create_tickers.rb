class CreateTickers < ActiveRecord::Migration[5.1]
  def change
    create_table :tickers do |t|
      t.integer :rank
      t.string :search_term
      t.string :symbol

      t.timestamps
    end
  end
end
