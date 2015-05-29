require 'sinatra'
require 'sinatra/reloader'

# methods within the helpers module are available to the view
helpers do
  # this method reads all lines from the file "enable.txt", then selects a random word
  # of the length specified.
  def sample(length, filename="enable.txt")
    dict = Array.new
    # open and read all lines from file
    File.open(filename, "r") do |file|
      while (!file.eof?)
        # remove the trailing '\n' that File#readline retains
        line = file.readline.chomp
        # only keep those words whose length match that specified.
        if (line.length == length)
          dict << line
        end
      end
    end

    # select a random word from the array of words (dict)
    dict.sample
  end

  def setup(length)
    @@secret = sample(length)
    @@progress = ""
    length.times do
      @@progress << "_"
    end
    @@incorrect = ""
    @@guesses = 0
  end

  # this method looks for matches in the secret word based on a letter specified. if a
  # match is found, progress will show the matched letter, otherwise progress will only
  # show an underscore letter.
  def guess?(letter)
    correct = false
    @@secret.length.times do |i|
      if (@@secret[i] == letter && @@progress[i] == '_')
        @@progress[i] = letter
        correct = true
      end
    end
    @@incorrect << letter if !correct
    @@guesses += 1
    puts("secret: #{@@secret}")
    correct
  end

  # this method displays the guessing progress made so far by padding letters with spaces
  def display(string)
    result = ""
    string.each_char do |char|
      result << "#{char} "
    end
    result
  end

  def display_progress
    display(@@progress)
  end

  def display_incorrect
    display(@@incorrect)
  end

  def victory?
    @@progress == @@secret
  end

  def game_over?
    @@guesses == 5
  end

  def secret
    @@secret
  end

  def guesses
    @@guesses
  end
end

# use of class variables to retain values in between browser GET's
@@secret = ""
@@progress = ""
@@incorrect = ""
@@guesses = 0
get '/' do
  erb :index, locals: {difficulty: params[:difficulty], letter: params[:letter]}
end
