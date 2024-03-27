module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id
    option :geocoder_service, default: proc { GeocoderService::GrpcClient.new }

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id
      @ad.lat = coordinates.lat
      @ad.lon = coordinates.lon

      if @ad.valid?
        @ad.save
      else
        fail! @ad.errors
      end
    end

    private

    def coordinates
      @coordinates ||= @geocoder_service.geocode(@ad.city)
    end
  end
end
