class UpdateEventScoresJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Ce job récupère les scores des événements terminés et met à jour les résultats des côtes en conséquence et crée des scores dans la db


    competitions = Competition.all
    competitions.each do |competition|
      response = Faraday.get("https://api.the-odds-api.com/v4/sports/#{competition.key}/scores") do |req|
        req.params["apiKey"] = "45db0d1f3d9d8a565881719f73a6b386"
        req.params["daysFrom"] = 1
        req.params["dateFormat"] = "iso"
        req.headers["Accept"] = "application/json"
      end

      if response.success?
        data = JSON.parse(response.body)
        data.each do |event_api|
          event = Event.find_by(id: event_api["id"])
          next unless event

          if event_api["completed"]
            event.update!(status: "finished")

            event_api["scores"].each do |score|
              event.scores.create!(name: score["name"], result: score["score"].to_i)
            end

            final_result = event.home_team_score.result - event.away_team_score.result
            if final_result > 0
              event.home_team_odd.update!(status: "won")
              event.away_team_odd.update!(status: "lost")
              event.draw_odd.update!(status: "lost")
            elsif final_result < 0
              event.home_team_odd.update!(status: "lost")
              event.away_team_odd.update!(status: "won")
              event.draw_odd.update!(status: "lost")
            else
              event.home_team_odd.update!(status: "lost")
              event.away_team_odd.update!(status: "lost")
              event.draw_odd.update!(status: "won")
            end
          end
        end
      else
        Rails.logger.error "Erreur API : #{response.status} - #{response.reason_phrase}, Response body: #{response.body}"
      end
    end
  end
end
