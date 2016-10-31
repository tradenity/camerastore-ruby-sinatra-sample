get '/' do
  categories = Category.find_all
  collections = Collection.find_all
  erb :index, locals: {categories: categories, collections: collections, cart:  ShoppingCart.get}, views: 'views/shop', layout_options: { views: 'views' }
end


get '/products' do
  raise SessionExpiredException.new(nil)
end
get '/products_' do
  if params.has_key? 'query'
    products =  Product.find_all(title: params['query'])
  else
    products =  Product.find_all
  end
  brands =  Brand.find_all
  categories =  Category.find_all
  featured =  Collection.find_one(name: 'featured')
  erb :products_layout, layout: :layout, locals: {categories: categories, brands: brands, featured: featured, cart: ShoppingCart.get }do
    erb :products, locals: {products: products, featured: featured}, views: 'views/shop', layout_options: { views: 'views' }
  end
end

get '/categories/:id' do
  brands =  Brand.find_all
  categories =  Category.find_all
  products =  Product.find_all(category: params['id'])
  featured =  Collection.find_one(name: 'featured')
  erb :products_layout, layout: :layout, locals: {categories: categories, brands: brands, featured: featured, cart:  ShoppingCart.get }do
    erb :products, views: 'views/shop', layout_options: { views: 'views' }, locals: {products: products, featured: featured}
  end
end

get '/brands/:id' do
  brands =  Brand.find_all
  categories =  Category.find_all
  products =  Product.find_all(brand: params['id'])
  featured =  Collection.find_one(name: 'featured')
  erb :products_layout, layout: :layout, locals: {categories: categories, brands: brands, featured: featured, cart:  ShoppingCart.get}do
    erb :products, views: 'views/shop', layout_options: { views: 'views' }, locals: {products: products, featured: featured}
  end
end

get '/products/:id' do
  brands =  Brand.find_all
  categories =  Category.find_all
  product =  Product.find_by_id(params['id'])
  featured =  Collection.find_one(name: 'featured')
  erb :products_layout, layout: :layout, locals: {categories: categories, brands: brands, featured: featured, cart: ShoppingCart.get} do
    erb :single, locals: {product: product}, views: 'views/shop', layout_options: { views: 'views' }
  end
end
