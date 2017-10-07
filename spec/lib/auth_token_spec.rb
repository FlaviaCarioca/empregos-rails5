require 'rails_helper'

RSpec.describe AuthToken do
  describe '.encode' do
    it 'encodes a payload' do
      payload = AuthToken.encode({ user_id: 5})

      expect(payload).not_to be_nil
    end

    it 'returns nil if encoding throws an error' do
      payload = AuthToken.encode(nil)

      expect(payload).to be_nil
    end
  end

  describe '.decode' do
    it 'decodes an encoded token' do
      encoded_token = AuthToken.encode({ user_id: 5})

      decoded_token = AuthToken.decode(encoded_token)

      expect(decoded_token).not_to be_nil
    end

    it 'returns nil if encoding throws an error' do
      payload = AuthToken.decode(nil)

      expect(payload).to be_nil
    end
  end
end
