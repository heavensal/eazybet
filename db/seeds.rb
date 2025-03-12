# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'faraday'
require 'json'

# Create competitions
# response = Faraday.get("https://api.the-odds-api.com/v4/sports") do |req|
#   req.params['apiKey'] = '45db0d1f3d9d8a565881719f73a6b386'
#   req.params['all'] = 'true'
#   req.headers['Accept'] = 'application/json'
# end

# if response.success?
#   data = JSON.parse(response.body)
#   puts data
#   data.each do |compet|
#     puts compet
#     competition = Competition.find_or_create_by!(key: compet['key'],
#                                                  group: compet['group'],
#                                                  title: compet['title'],
#                                                  description: compet['description'],
#                                                  active: compet['active'],
#                                                  has_outrights: compet['has_outrights'])
#     puts "Competition #{competition.title} created"
#   end
# else
#   puts "Erreur : #{response.status} - #{response.reason_phrase}"
# end
#
# Competition.create!(key: "soccer_france_ligue_one", group: "Soccer", title: "Ligue 1 - France", description: "French Soccer", active: true, has_outrights: false)
# puts "Competition soccer_france_ligue_one created"

# Competition.create!(key: "soccer_epl", group: "Soccer", title: "EPL", description: "English Premier League", active: true, has_outrights: false)
# puts "Competition soccer_epl created"

# Competition.create!(key: "soccer_germany_bundesliga", group: "Soccer", title: "Bundesliga - Germany", description: "German Soccer", active: true, has_outrights: false)
# puts "Competition soccer_germany_bundesliga created"

# Competition.create!(key: "soccer_italy_serie_a", group: "Soccer", title: "Serie A - Italy", description: "Italian Soccer", active: true, has_outrights: false)
# puts "Competition soccer_italy_serie_a created"

# Competition.create!(key: "soccer_spain_la_liga", group: "Soccer", title: "La Liga - Spain", description: "Spanish Soccer", active: true, has_outrights: false)
# puts "Competition soccer_spain_la_liga created"

# Competition.create!(key: "soccer_uefa_champs_league", group: "Soccer", title: "UEFA Champions League", description: "European Champions League", active: true, has_outrights: false)
# puts "Competition soccer_uefa_champs_league created"

# Competition.create!(key: "soccer_uefa_europa_conference_league", group: "Soccer", title: "UEFA Europa Conference League", description: "UEFA Europa Conference League", active: true, has_outrights: false)
# puts "Competition soccer_uefa_europa_conference_league created"

# Competition.create!(key: "soccer_uefa_europa_league", group: "Soccer", title: "UEFA Europa League", description: "European Europa League", active: true, has_outrights: false)
# puts "Competition soccer_uefa_europa_league created"

# Create Events
params = {
  apiKey: api_key,
  regions: "eu",
  markets: "h2h",
  dateFormat: "iso",
  oddsFormat: "decimal",
  bookmakers: "winamax_fr",
  commenceTimeFrom: "2025-03-12T00:00:00Z",
  commenceTimeTo: "2025-03-19T00:00:00Z",  # Correction de l'année pour éviter incohérence
  includeLinks: "false",
  includeSids: "false",
  includeBetLimits: "false"
}

response = Faraday.get("https://api.the-odds-api.com/v4/sports/#{sport_key}/odds") do |req|
  req.params['apiKey'] = '45db0d1f3d9d8a565881719f73a6b386'
  req.params['all'] = 'true'
  req.headers['Accept'] = 'application/json'
end

if response.success?
  data = JSON.parse(response.body)
  puts data
  data.each do |compet|
    puts compet
    competition = Competition.find_or_create_by!(key: compet['key'],
                                                 group: compet['group'],
                                                 title: compet['title'],
                                                 description: compet['description'],
                                                 active: compet['active'],
                                                 has_outrights: compet['has_outrights'])
    puts "Competition #{competition.title} created"
  end
else
  puts "Erreur : #{response.status} - #{response.reason_phrase}"
end
