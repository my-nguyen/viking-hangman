require 'sinatra'
require 'sinatra/reloader'

get '/' do
  "The SECRET NUMBER is #{rand(0..100)}"
end
