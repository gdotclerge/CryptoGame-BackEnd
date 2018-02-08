class User < ApplicationRecord
  has_many :portfolios
  has_many :tickers, through: :portfolios
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true

end
