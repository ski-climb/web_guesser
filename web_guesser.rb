require 'sinatra'
require 'sinatra/reloader'

number = rand(100) + 1

get '/' do
  erb :index, :locals => { :number => number }
end
