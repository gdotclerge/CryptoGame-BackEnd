class CreateTickers < ActiveRecord::Migration[5.1]
  def change
    create_table :tickers do |t|
      t.string :search_term
      t.integer :rank

      t.timestamps
    end
  end
end
