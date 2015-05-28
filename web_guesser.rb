require 'sinatra'
require 'sinatra/reloader'

def check_guess(guess)
  secret = settings.secret

  if guess > secret
    if (guess - secret > 5)
      "Way too high!"
    else
      "Too high!"
    end
  elsif guess < secret
    if (secret - guess > 5)
      "Way too low!"
    else
      "Too low!"
    end
  else
    "You got it right!"
  end
end

set :secret, rand(0..100)
get '/' do
  check_msg = check_guess(params[:guess].to_i)
  erb :index, locals: {message: check_msg}
end
