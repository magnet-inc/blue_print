Dummy::Application.routes.draw do
  mount ApplicationApi => '/api'

  get 'echo/:text' => 'echo#show'
end
