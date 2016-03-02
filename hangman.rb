#creates an array with the 7 possible ascii art from (0..6) lives
$art =[ """
  __________
  | /      |
  |/       @
  |       /|\\
  |       / \\
  |\\
__|_\\__________
""",
  """
  __________
  | /      |
  |/       @
  |       /|\\
  |         \\
  |\\
__|_\\__________

""",
"""
  __________
  | /      |
  |/       @
  |       /|\\
  |
  |\\
__|_\\__________

""",
"""
  __________
  | /      |
  |/       @
  |       /|
  |
  |\\
__|_\\__________

""",
"""
  __________
  | /      |
  |/       @
  |
  |
  |\\
__|_\\__________

""",
"""
  __________
  | /      |
  |/
  |
  |
  |\\
__|_\\__________

""",
"""
  __________
  | /
  |/
  |
  |
  |\\
__|_\\__________

"""
]

$dict = ["exquisite","ruthless", "anarchist", "nylon", "cat","fireman", "horse",
        "pig", "snail", "crackers", "quakers", "insurrection", "election"]

class Game
  def initialize
    @word = $dict[rand($dict.length)]
    @display_guesses = Array.new(@word.length, "__ ")
    @past_guesses = []
    @lives = 6
    @win = false
    @lose = false
  end

  def display
      require './hangman_art.rb'
      @lose = (@lives == 0)
      @win = !(@display_guesses.include?("__ "))
      system("clear")
      puts "H A N G M A N"
      puts "\n"
      puts "#{$art[@lives]}\n\n"

    #displays either winning, losing or prompt screen
    if @win
      puts "Word: #{@display_guesses.join(" ")}\n"
      puts "Past Guesses: #{@past_guesses.join(", ")}\n"
      puts "\n\nYOU WIN! Congradulations!\n\n"
    elsif @lose
      puts "Word: #{@display_guesses.join(" ")}\n"
      puts "Past Guesses: #{@past_guesses.join(", ")}\n"
      puts "OH NO!!!\n"
      puts "\n The word was #{@word.upcase} \n"
      puts "\n\n YOU LOSE. \n\n BETTER LUCK NEXT TIME.\n"

    else
      puts "Word: #{@display_guesses.join(" ")}\n"
      puts "Past Guesses: #{@past_guesses.join(", ")}\n"
      turn
    end
  end

#processes the guess
  def guess(guess)
    search = 0
    pos = []
    if @word.index(guess, search) == nil
      print "not there"
      @lives -= 1
      @past_guesses << guess
      display
    else
      until @word.index(guess, search) == nil
        pos << @word.index(guess, search)
        search = @word.index(guess, search) + 1
      end
    return pos
    end
  end

#gets an input from the user
  def get_guess
    print "> "
    guess = $stdin.gets.chomp.downcase
    if guess_is_valid?(guess)
      return guess
    else
      get_guess
    end
  end

#makes sure the guess is one character long and is new
  def guess_is_valid?(guess)
    if guess.length != 1
      puts "Please enter a single letter"
      return false
    elsif @past_guesses.include? guess or @display_guesses.include? guess
      puts "Let's try a new letter "
      return false
    else
      return true
    end
  end


  def turn
    puts "What is your guess?"
    guess = get_guess

    pos = guess(guess)

    unless pos.class != Array 
      pos.each do |pos|
        @display_guesses[pos] = guess
      end
    end


    display
  end


end




Game.new.display
