require 'sinatra'
require 'sinatra/reloader'

myrand = rand(0..100)
get '/' do
  erb :index, :locals => {:number => myrand}
end
