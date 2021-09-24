module GeocoderService
  module Api
    def geocode(city)
      response = connection.post('geocode')

      response.body if response.success?
    end
  end
end
