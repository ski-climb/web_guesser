require 'sinatra'
require 'sinatra/reloader'

message = ""
set :secret_number, rand(100) + 1

def set_message(guess)
  return correct(guess) if correct?(guess)
  return too_high(guess) if too_high?(guess)
  return too_low(guess) if too_low?(guess)
end

def too_high(guess)
  if guess > settings.secret_number + 5
    "Way too high!"
  else
    "Too high!"
  end
end

def too_high?(guess)
  guess > settings.secret_number
end

def too_low(guess)
  if guess < settings.secret_number - 5
    "Way too low!"
  else
    "Too low!"
  end
end

def too_low?(guess)
  guess < settings.secret_number
end

def correct?(guess)
  guess == settings.secret_number
end

def correct(guess)
  "You got it right!<br />The SECRET NUMBER is #{settings.secret_number}"
end

get '/' do
  guess = params['guess'].to_i
  message = set_message(guess)
  erb :index, locals: {
                        number: settings.secret_number,
                        guess: guess,
                        message: message
                      }
end
