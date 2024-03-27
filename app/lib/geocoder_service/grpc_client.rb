
module GeocoderService
  class GrpcClient
    def geocode(city)
      stub.geocode(Geocoder::City.new(name: city))
    end

    private

    def stub
      @stub ||= Geocoder::GeocoderService::Stub.new(
        '127.0.0.1:50051', :this_channel_is_insecure
      )
    end
  end
end
