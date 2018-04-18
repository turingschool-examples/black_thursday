require 'sinatra'
require_relative '../lib/sales_analyst'

get '/' do
  "Black Thursday!"
end

get '/dashboard' do
  haml :dashboard
end
