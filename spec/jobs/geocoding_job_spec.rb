RSpec.describe GeocodingJob, type: :job do
  subject { described_class }

  let(:ad) { create(:ad, city: 'City 17') }
  let(:geocoder_service) { instance_double('Geocoder service') }

  context 'existing city' do
    let(:lat) { 45.05 }
    let(:lon) { 90.05 }

    before do
      allow(geocoder_service).to receive(:geocode).with('City 17').and_return([lat, lon])
      allow(GeocoderService::Client).to receive(:new).and_return(geocoder_service)
    end

    it 'updates ad coordinates' do
      subject.perform_now(ad)

      expect(ad.lat).to eq(lat)
      expect(ad.lon).to eq(lon)
    end
  end

  context 'missing city' do
    before do
      allow(geocoder_service).to receive(:geocode).with('City 17').and_return(nil)
      allow(GeocoderService::Client).to receive(:new).and_return(geocoder_service)
    end

    it 'does not update ad coordinates' do
      subject.perform_now(ad)

      expect(ad.lat).to be_nil
      expect(ad.lon).to be_nil
    end
  end
end
