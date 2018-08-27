
get '/login' do
  erb :login, layout: :simple_layout, views: 'views/account', layout_options: { views: 'views' }
end

post '/login' do
  customer = Customer.find_one_by(username: params['username'])
  if customer != nil && valid_password?(customer.password, params['password'])
    session[:customer_id] = customer.id
    if session.has_key? :target_url
      target_url = session[:target_url]
      session.delete(:target_url)
    else
      target_url = '/'
    end
    redirect to(target_url)
  else
    erb :login, layout: :simple_layout, views: 'views/account', layout_options: { views: 'views' }
  end
end

get '/logout' do
  session.delete(:customer_id)
  redirect to('/')
end


get '/register' do
  erb :register, layout: :simple_layout, views: 'views/account', layout_options: { views: 'views' }
end

post '/register' do
  customer = Customer.new(first_name: params['first_name'],
                          last_name: params['last_name'],
                          email: params['email'],
                          username: params['username'],
                          password: params['password'],
                          status: 'enabled')
  if params['password'] == params['confirm_password'] && customer.valid?
    customer.create
    redirect to('/login')
  else
    erb :register, layout: :simple_layout, views: 'views/account', layout_options: { views: 'views' }
  end
end
