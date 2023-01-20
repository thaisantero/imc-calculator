require 'rails_helper'

RSpec.describe JsonWebToken, type: :model do
  describe '#self.decode' do
    context 'when token is valid' do
      it 'returns nil' do
        expect(JsonWebToken.decode('valid_token')).to be_nil
      end
    end

    context 'when token is invalid' do
      it 'raises JsonWebToken::DecodeError' do
        expect { JsonWebToken.decode('invalid_token') }.to raise_error(JsonWebToken::DecodeError)
      end
    end
  end
end
