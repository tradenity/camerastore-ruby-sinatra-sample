Welcome to CameraStore Ruby/Sinatra sample
===================================

## Ruby/Sinatra sample application for Tradenity ecommerce API

This is a sample application for [Tradenity](https://www.tradenity.com) ecommerce API using the [Ruby SDK](https://github.com/tradenity/ruby-sdk) with Sinatra micro framework to build ecommerce web application.

This sample application is free and open source, we encourage you to fork it and use it as a base for your future applications.

To run it on your local machine:


## Create store and load sample data

- If you are not yet registered, create a new [Tradenity account](https://www.tradenity.com).
- After you login to your account, go to [Getting started](https://admin.tradenity.com/admin/getting_started) page, click "Create sample store", this will create a new store and populate it with sample data
- From the administration side menu, choose "Developers" > "API Keys", you can use the default key or generate a new one.



## Ruby runtime

-  Ruby >= 2.2 (Other versions may work but this is the tested version)

## Get the application

Choose one of the following:

- Download the source code.
- Clone `git clone git@github.com:tradenity/camerastore-ruby-sinatra-sample.git`
- Fork this repository

## Add Store Credentials

Open `config.ru`, modify this line: 

```ruby
Tradenity.configure do |config|
  config.username = "sk_xxxxxxxxxxxxxxxxxxxxxxxxx"
  config.password = ""
  config.session_token_holder = Tradenity::SessionTokenHolder.new
end
``` 

to reflect your store's API key.

If you configured your store to use stripe for payment processing, then edit this line:

`STRIPE_PUBLIC_KEY = 'pk_xxxxxxxxxxxxxxxxxxxxxxxxxx'` to reflect your public key.


## Install requirements

`bundle install`

## Run


`bundle exec rackup config.ru`

## Documentation & Explanation

Refer to this [tutorial](http://docs.tradenity.com/kb/tutorials/ruby/sinatra/)
on our knowledge base for full explanation of the source code.

## Live demo

You can see and interact with a live demo of this application [here](http://camera-store-sample.tradenity.com)