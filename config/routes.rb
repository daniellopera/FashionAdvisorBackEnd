Rails.application.routes.draw do





  # Tells the router to use the controllers located in /controllers/users
  # This routes are specifically for the users registration, authentication and authorization
  # done by the devise gem and the simple toke authentication gems.
  devise_for :users, controllers: {
                                    sessions: 'users/sessions',
                                    registrations: 'users/registrations'
                                  }


  root 'products#search'

  get 'search/' => 'products#search'
  get 'colors/' => 'products#list_colors'
  get 'brands/' => 'brands#list_brands'
  get 'brands/search/:search_param' => 'brands#autocomplete_brands'
 # get 'brands/update' => 'brands#update_brands'
  get 'user/products' => 'products#bring_products_from_wardrobe'
  post 'user/products'=> 'products#add_product_to_wardrobe'
  post 'user/outfits' => 'outfits#create'
  post 'rating/rate'  => 'ratings#rate_an_outfit'
  post 'comments/comment' => 'comments#comment_an_outfit'
  get 'user/outfits'  => 'outfits#bring_outfits_from_wardrobe'
  get 'users/search'  => 'users#search'
  get 'user/following'  => 'users#follow'
  

end
