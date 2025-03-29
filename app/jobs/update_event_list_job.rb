class UpdateEventListJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Récupérer toutes les compétitions
    competitions = Competition.all

    competitions.each do |competition|
      response = Faraday.get("https://api.the-odds-api.com/v4/sports/#{competition.key}/odds") do |req|
        req.params["apiKey"] = "e8a6d343cffeead6c8ebca1c59738f03"
        req.params["regions"] = "eu"
        req.params["markets"] = "h2h"
        req.params["dateFormat"] = "iso"
        req.params["oddsFormat"] = "decimal"
        req.params["bookmakers"] = "winamax_fr"
        req.params["includeLinks"] = "false"
        req.params["includeSids"] = "false"
        req.params["includeBetLimits"] = "false"
        req.headers["Accept"] = "application/json"
      end

      if response.success?
        data = JSON.parse(response.body)

        data.each do |event|
          # Vérifier que l'événement est valide
          next unless event["id"] && event["commence_time"] && event["home_team"] && event["away_team"]

          event_record = Event.find_or_create_by!(id: event["id"]) do |e|
            e.commence_time = event["commence_time"]
            e.home_team = event["home_team"]
            e.away_team = event["away_team"]
            e.status = "pending"
            e.competition_id = competition.id
          end

          # Vérifier et extraire les cotes
          if event["bookmakers"] && event["bookmakers"].any?
            odds_data = event["bookmakers"].first["markets"].first["outcomes"] rescue []

            odds_data.each do |odd|
              next unless odd["name"] && odd["price"]

              begin
                Odd.find_or_create_by!(name: odd["name"], event_id: event_record.id) do |o|
                  o.price = odd["price"]
                  o.status = "pending"
                end
              rescue ActiveRecord::RecordInvalid => e
                Rails.logger.error "Échec d'insertion de l'Odd : #{e.record.errors.full_messages}"
                puts "Échec d'insertion de l'Odd : #{e.record.errors.full_messages}"
              end
            end
          end
        end
      else
        Rails.logger.error "Erreur API : #{response.status} - #{response.reason_phrase}, Response body: #{response.body}"
      end
    end
  end
end
