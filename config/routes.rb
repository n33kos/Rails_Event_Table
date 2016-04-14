Rails.application.routes.draw do
  root 'events#index'
  get '(/:date)(/:sort)' => 'events#bydate'
  post 'events(.:format)' => 'events#create'
end
