Rails.application.routes.draw do

  get 'messages/reply'
  root "bases#index"
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get "/base", to: "base#index"
  resources :bases
  post "/bases/sendMessage", to: "bases#sendMessage"
  post "/bases/Choice", to: "bases#Choice"
 
  get 'messages/inbox'
  get 'messages/convo'
  post "/messages/inbox", to: "messages#inbox"
  post "/messages/convo", to: "messages#convo"
  post "/messages/sendMessage", to: "messages#sendMessage"
  post "/messages/convoMessage", to: "messages#convoMessage"

  resources :posts

  
  resource :messages do 
    resources :conversations
    collection do
      post 'reply'
    end
    post "/messages/display", to: "messages#display"
  end
end
