require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100) + 1

def set_message(guess)
  return correct      if correct?(guess)
  return too_high     if too_high?(guess)
  return way_too_high if way_too_high?(guess)
  return too_low      if too_low?(guess)
  return way_too_low  if way_too_low?(guess)
end

def set_color(guess)
  return "crimson"    if ( way_too_low?(guess) || way_too_high?(guess) )
  return "lightcoral" if (     too_low?(guess) ||     too_high?(guess) )
  return "lightgreen" if       correct?(guess)
end

def correct
  "You got it right!<br />The SECRET NUMBER is #{settings.secret_number}"
end

def way_too_high
  "Way too high!"
end

def way_too_low
  "Way too low!"
end

def too_high
  "Too high!"
end

def too_low
  "Too low!"
end

def way_too_high?(guess)
  guess > settings.secret_number + 5
end

def too_high?(guess)
  guess > settings.secret_number && guess <= settings.secret_number + 5
end

def way_too_low?(guess)
  guess < settings.secret_number - 5
end

def too_low?(guess)
  guess < settings.secret_number && guess >= settings.secret_number - 5
end

def correct?(guess)
  guess == settings.secret_number
end

get '/' do
  guess = params['guess'].to_i
  message = set_message(guess)
  color = set_color(guess)
  erb :index, locals: {
                        number: settings.secret_number,
                        guess: guess,
                        message: message,
                        color: color
                      }
end
