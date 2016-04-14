Rails.application.routes.draw do
  root 'events#index'
  get 'events(/:date)(/:sort)' => 'events#bydate'
end
