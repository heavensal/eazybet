class ResetDailyAdsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # On va chercher tous les users qui sont pas admin
    users = User.where.not(role: "admin")
    users.each do |user|
      user.set_ads_count(20)
    end
    Rails.logger.info "[ResetDailyAdsJob] Reset du compteur de pub pour tous les users"
  end
end
