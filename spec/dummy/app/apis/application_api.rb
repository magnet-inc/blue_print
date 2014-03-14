class ApplicationApi < Grape::API
  get 'version' do
    BluePrint::VERSION
  end
end
