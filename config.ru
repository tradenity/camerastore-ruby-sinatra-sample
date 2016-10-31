require 'rubygems'
require 'bundler'
require 'bundler/setup'

Bundler.require

Tradenity.api_key = 'sk_xxxxxxxxxxxxxxxxxxxxxxx'

STRIPE_PUBLIC_KEY = 'pk_xxxxxxxxxxxxxxxxxxxxxxx'

require './camerastore'
require './camerastore_error_handler'
require './camerastore_accounts'
require './camerastore_shop'
require './camerastore_cart'
require './camerastore_orders'

run Sinatra::Application