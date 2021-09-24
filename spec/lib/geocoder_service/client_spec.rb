RSpec.describe GeocoderService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:coords) { [51.2,52.5] }
  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }
  let(:city) { 'Moscow' }

  before do
    stubs.post('geocode') { [status, headers, body.to_json] }
  end

  describe '#geocode (city is found)' do
    let(:body) { { 'meta' => { 'coordinates' => coords } } }

    it 'returns user_id' do
      expect(subject.geocode(city)['meta']['coordinates']).to eq coords
    end
  end

  describe '#auth (city is not found)' do
    let(:body) { { 'meta' => { 'coordinates' => nil } } }

    it 'returns a nil value' do
      expect(subject.geocode(city)['meta']['coordinates']).to be_nil
    end
  end
end
