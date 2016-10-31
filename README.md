Welcome to CameraStore Rails sample
===================================

## Ruby/Rails sample application for Tradenity ecommerce API

This is a demonstration of using [Tradenity Ruby SDK](https://github.com/tradenity/ruby-sdk) with Rails to build ecommerce web application.

This sample application is free and opensource, we encourage you to fork it and use it as a base for your future applications.

To run it on your local machine:

## Prerequisites

-  Ruby >= 2.2 (Other versions may work but this is the tested version)

## Get the application

Choose one of the following:

- Download the source code.
- Clone `git clone git@github.com:tradenity/camerastore-ruby-sinatra-sample.git`
- Fork this repository

## Add Store Credentials

Open `config.ru`, modify this line: 

`Tradenity.API_KEY = 'sk_xxxxxxxxxxxxxxxxx'` 

to reflect your store's API key.

If you configured your store to use stripe for payment processing, then edit this line:

`STRIPE_PUBLIC_KEY = 'pk_xxxxxxxxxxxxxxxxxxxxxxxxxx'` to reflect your public key.


## Install requirements

`bundle install`

## Run


`rackup config.ru`

## Documentation & Explanation

Refer to this [tutorial](http://docs.tradenity.com/kb/tutorials/ruby/sinatra/)
on our knowledge base for full explanation of the source code