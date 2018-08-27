#require 'rubygems'
#require 'bundler/setup'
#require "sinatra"
require 'json'
require 'bcrypt'

include Tradenity

enable :sessions

# add this configuration line to allow exception handling to work in development
set :show_exceptions, :after_handler

helpers do
  def authenticated?
    session.has_key? :customer_id
  end
end


before do
  Configuration.default.session_token_holder.session = session
  # HttpClient.get_instance.current_session(session)
end





