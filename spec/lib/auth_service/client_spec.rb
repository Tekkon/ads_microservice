RSpec.describe AuthService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.post('auth') { [status, headers, body.to_json] }
  end

  describe "#auth" do
    context "when the token is valid" do
      let(:user_id) { 101 }
      let(:body) { { 'meta' => { 'user_id' => user_id } } }

      it 'returns user_id' do
        expect(subject.auth('valid.token')).to eq(user_id)
      end
    end

    context "when the token is invalid" do
      let(:status) { 403 }

      it "return nil" do
        expect(subject.auth('invalid.token')).to be_nil
      end
    end

    context "when the token is nil" do
      let(:status) { 403 }

      it "return nil" do
        expect(subject.auth(nil)).to be_nil
      end
    end
  end
end
