require 'spec_helper'

describe EchoController, type: :request do
  describe 'GET /echo/text' do
    it 'returns echo response' do
      get '/echo/text'
      expect(response.body).to eq('text')
    end
  end
end
