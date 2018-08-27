
get '/cart' do
  categories =  Category.find_all
  erb :cart, layout: :layout, locals: {categories: categories, cart:  ShoppingCart.get}, views: 'views/shop', layout_options: { views: 'views' }
end

post '/cart/add' do
  cart = ShoppingCart.add_item(LineItem.new(product: Product.new(id: params['product']), quantity: params['quantity']))
  content_type :json
  { total: cart.total, count: cart.items.size }.to_json
end

post '/cart/remove/:id' do
  cart = ShoppingCart.delete_item(params['id'])
  content_type :json
  { total: cart.total, count: cart.items.size }.to_json
end
