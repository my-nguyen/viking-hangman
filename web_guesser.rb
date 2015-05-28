require 'sinatra'
require 'sinatra/reloader'

def reset
  @@secret = rand(0..100)
  @@guesses = 5
end

def check_guess(guess)
  result = ""

  if guess == @@secret
    result = "You got it right!"
    reset
  else
    if guess > @@secret
      if (guess - @@secret > 5)
        result = "Way too high!"
      else
        result = "Too high!"
      end
    else
      if (@@secret - guess > 5)
        result = "Way too low!"
      else
        result = "Too low!"
      end
    end

    @@guesses -= 1
    if (@@guesses == 0)
      reset
      result = "You've lost! A new number has been generated."
    end
  end

  result
end

reset
get '/' do
  result = params[:guess].nil? ? "" : result = check_guess(params[:guess].to_i)
  erb :index, locals: {message: result, number: params[:guess]}
end
