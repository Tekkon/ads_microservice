class GeocodingJob < ApplicationJob
  queue_as :default

  def perform(ad)
    coordinates = GeocoderService::Client.new.geocode(ad.city)
    return if coordinates.blank?

    ad.lat, ad.lon = coordinates['meta']['coordinates'].map(&:to_f)
    ad.save!
  end
end
