require 'rest-client'
require 'json'
require 'pry'
require 'faker'


url = 'https://api.coinmarketcap.com/v1/ticker/?limit=0'
response = RestClient.get(url)
info = JSON.parse(response)

info.each do |crypto|
  Ticker.create(search_term: crypto["id"], rank: crypto["rank"], symbol: crypto["symbol"])
end


10.times do
  pokemon = Faker::Pokemon.unique.name
  User.create(username:pokemon, password: pokemon)
end
