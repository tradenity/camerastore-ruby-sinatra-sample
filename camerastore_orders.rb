
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
  usa = Country.find_one_by(iso2: "US")
  countries = Country.find_all_by(size: 250, sort: "name")
  states = State.find_all_by(country: usa.id, size: 60, sort: "name")
  cart = ShoppingCart.get
  customer = Customer.find_by_id session[:customer_id]
  order = Order.new(customer: customer, billing_address: create_address(usa), shipping_address: create_address(usa))
  erb :checkout, layout: :simple_layout, views: 'views/orders', layout_options: { views: 'views' },
      locals: {cart: cart, order: order, countries: countries, states: states, stripe_pub_key: ""}
end

post '/orders/create' do
  customer = Customer.new
  customer.id = session[:customer_id]
  order = Order.new(customer: customer,
                    billing_address: populate_address(params['billing_address']),
                    shipping_address: populate_address(params['shipping_address']))
  begin
    order.create
    session[:order_id] = order.id
    shipping_methods = ShippingMethod.find_all_for_order(order.id)
    erb :shipping_form, locals: {shipping_methods: shipping_methods }, views: 'views/orders'
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end
end

post '/orders/shipping' do
  order = Order.find_by_id session[:order_id]
  order.shipping_method = ShippingMethod.new(id: params["shipping_method"])
  order.update
  erb :payment_form, views: 'views/orders'
end

post '/orders/payment' do
  order = Order.find_by_id session[:order_id]
  payment_source = PaymentToken.new(token: params['token'], customer: Customer.new(id: session[:customer_id]), status: "new").create
  CreditCardPayment.new(order: order, payment_source: payment_source).create
  redirect to("/orders/#{order.id}")
end

get '/orders/:id' do
  order = Order.find_by_id(params['id'])
  erb :show, layout: :simple_layout, views: 'views/orders', layout_options: { views: 'views' }, locals: {order: order}
end

post '/orders/refund/:id' do
  transaction = Order.refund(params['id'])
  redirect to("/orders/#{params['id']}")
end

def populate_address(params)
  Address.new(street_line1: params['street_line1'],
                   street_line2: params['street_line2'],
              city: params['city'],
              state: State.new('id' => params['state']),
              zip_code: params['zip_code'],
              country: Country.new('id' => params['country']))
end

def create_address(us)
  Address.new(street_line1: "3290 Hermosillo Place", street_line2: "", city: "Washington", state: State.new, zip_code: "20521-3290", country: us)
end
