Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'query/new'
  post 'query/result'








  root 'query#new'
end
