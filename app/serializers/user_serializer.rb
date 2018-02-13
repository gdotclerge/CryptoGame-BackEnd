class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :unspent_money

  has_many :portfolios
end
