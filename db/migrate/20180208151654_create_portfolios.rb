class CreatePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :ticker, foreign_key: true
      t.float :purchase_amount
      t.float :purchase_price

      t.timestamps
    end
  end
end
