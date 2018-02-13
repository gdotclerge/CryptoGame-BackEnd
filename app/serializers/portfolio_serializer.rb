class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :purchase_amount, :purchase_price, :user_id, :ticker_id

end
