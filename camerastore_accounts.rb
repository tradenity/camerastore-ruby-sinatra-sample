
get '/login' do
  erb :login, layout: :simple_layout, views: 'views/account', layout_options: { views: 'views' }
end

post '/login' do
  customer = Customer.find_by_username(params['username'])
  if customer != nil && customer.valid_password?(params['password'])
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
  customer = Customer.new(firstName: params['firstName'],
                          lastName: params['lastName'],
                          email: params['email'],
                          username: params['username'],
                          password: params['password'])
  customer.create()
  redirect to('/login')
end
