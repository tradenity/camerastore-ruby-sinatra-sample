require 'rubygems'
require 'bundler'
require 'bundler/setup'

Bundler.require

Tradenity.configure do |config|
  config.username = "sk_xxxxxxxxxxxxxxxxxxxxxxxxx"
  config.password = ""
  config.session_token_holder = Tradenity::SessionTokenHolder.new
end

STRIPE_PUBLIC_KEY = 'pk_xxxxxxxxxxxxxxxxxxxxxxx'

require './camerastore'
require './camerastore_error_handler'
require './camerastore_accounts'
require './camerastore_shop'
require './camerastore_cart'
require './camerastore_orders'

run Sinatra::Application