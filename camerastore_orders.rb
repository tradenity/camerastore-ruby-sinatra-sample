
before '/orders*' do
  unless session.has_key? :customer_id
    session[:target_url] = request.path
    redirect to '/login'
  end
end

get '/orders' do
  orders = Order.find_all_by(customer:  session[:customer_id])
  erb :index, layout: :simple_layout, views: 'views/orders', layout_options: { views: 'views' }, locals: {orders: orders}
end

get '/orders/checkout' do
  customer = Customer.find_by_id session[:customer_id]
  order = Order.new(customer: customer, billing_address: create_address, shipping_address: create_address)
  erb :checkout, layout: :simple_layout, views: 'views/orders', layout_options: { views: 'views' }, locals: {order: order}
end

get '/orders/:id' do
  order = Order.find_by_id(params['id'])
  erb :show, layout: :simple_layout, views: 'views/orders', layout_options: { views: 'views' }, locals: {order: order}
end



post '/orders/create' do
  customer = Customer.new
  customer.id = session[:customer_id]
  order = Order.new(customer: customer,
                    billingAddress: Address.new(params['billingAddress']),
                    shippingAddress: Address.new(params['shippingAddress']))
  transaction = order.checkout(params['token'])
  redirect to("/orders/#{transaction.order.id}")
end

post '/orders/refund/:id' do
  transaction = Order.refund(params['id'])
  redirect to("/orders/#{params['id']}")
end

def create_address
  Address.new(streetLine1: "3290 Hermosillo Place", streetLine2: "", city: "Washington", state: "Washington, DC", zipCode: "20521-3290", country: "USA")
end
