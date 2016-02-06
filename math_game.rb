require 'pry'
require 'colorize'
require './player'

puts "What is player 1's name?"
player_1 = Player.new(gets.chomp.to_s)

puts "What is player 2's name?"
player_2 = Player.new(gets.chomp.to_s)

# Generates two random numbers between 1 and 20 and uses these numbers to create a simple addition, subtraction, or multiplication question
def generate_question
  num_1 = rand(1..20)
  num_2 = rand(1..20)
  operation = ['add', 'subtract', 'multiply'].sample

  if operation == 'add'
    @answer = num_1 + num_2
    @question = "What is the " + "sum".colorize(:bold).bold + " of #{num_1} and #{num_2}?"
  elsif operation == 'subtract'
    @answer = num_1 - num_2
    @question = "What is the " + "difference".colorize(:bold).bold + " between #{num_1} and #{num_2}?"
  elsif operation == 'multiply'
    @answer = num_1 * num_2
    @question = "What is the " + "product".colorize(:bold).bold + " of #{num_1} and #{num_2}?"
  else
  end
end

# Takes @player_1.score or @player_2.score as an argument. 
# Puts the string interpoloation of @player_1.score or @player_2.score plus the question created by generate_question, then asks for user input.
# Stores user input in @player_answer. 
# If no argument is passed, NoArgument Error (0 for 1).
def prompt_player_for_answer(player)
  puts "#{player}".colorize(:underline).underline + ": #{@question}"
  @player_answer = gets.chomp.to_i
end

# Checks if @player_answer is equal to the actual answer and returns true or false accordingly
def verify_answer
  @player_answer == @answer ? true : false
end

# Takes @player_1.score or @player_2.score as an argument. 
# Calls generate question to get @question, then calls prompt player for answer to get @player_answer, then calls verify_answer to check if @player_answer is correct. If @player_answer is correct, puts "Correct" and returns the altered scores and lives of each player.
# If no argument is passed, NoArgument Error (0 for 1).
def play_round(player)
  generate_question
  prompt_player_for_answer(player)
  verify_answer
  if verify_answer
    puts "Correct!".colorize(:green)
    player == "#{@player_1.name}" ? @player_1.gain_point : @player_2.gain_point
  else
    puts "Incorrect.".colorize(:red)
    player == "#{@player_1.name}" ? @player_1.lose_life : @player_2.lose_life
  end
end

# Checks the lives of @player_1 and @player_2 to determine who won the game or if there was a tie.
# Displays the winner of the most recent game as well as the total scores of each player.
def display_results
  if @player_1.lives == 0 && @player_2.lives == 0
    puts "Tie!"
  elsif @player_2.lives == 0
    puts "#{@player_1.name} won the round!"
  else
    puts "#{@player_2.name} won the round!"
  end

  puts "Total Scores"
  puts "#{@player_1.name}: #{@player_1.score}"
  puts "#{@player_2.name}: #{@player_2.score}"
end

# Checks the :lives of @player_1 and @player_2 to determine if the game is over or if another round of questions should be displayed. 
# Calls play_round if :lives of both players is not zero. 
# Calls display_results, then play_again? if the :lives of both players is zero.
def play_game
  while @player_1.lives != 0 && @player_2.lives != 0
    play_round("#{@player_1.name}")
    play_round("#{@player_2.name}")
  end

  display_results
  play_again?
end

# Asks the player for input to determine if they would like to replay the game or exit.
# If the player indicates they would like to play again, resets the :lives of each player to 3 and calls play_game
# If the player does not want to play again, the program ends.
def play_again?  
  puts "Do you want to play again? (yes or no)"
  @play_again = gets.chomp.to_s

  if @play_again == 'yes'
    @player_1.lives = 3
    @player_2.lives = 3
    play_game
  else
  end
end

binding.pry
create_players
play_game