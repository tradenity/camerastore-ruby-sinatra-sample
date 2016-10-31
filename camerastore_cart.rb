
get '/cart' do
  categories =  Category.find_all
  erb :cart, layout: :layout, locals: {categories: categories, cart:  ShoppingCart.get}, views: 'views/shop', layout_options: { views: 'views' }
end

post '/cart/add' do
  cart = ShoppingCart.add(LineItem.new(product: Product.new(id: params['product']), quantity: params['quantity']))
  content_type :json
  { total: cart.total, count: cart.count }.to_json
end

post '/cart/remove/:id' do
  cart = ShoppingCart.remove(params['id'])
  content_type :json
  { total: cart.total, count: cart.count }.to_json
end
