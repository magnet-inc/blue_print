require 'spec_helper'

describe ApplicationApi, type: :request do
  describe 'GET /api/version' do
    it 'returns blue print version' do
      get '/api/version'
      expect(response.body).to eq(BluePrint::VERSION)
    end
  end
end
