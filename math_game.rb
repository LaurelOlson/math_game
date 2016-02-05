require 'pry'
require 'colorize'

@player_1 = {
  name: "",
  lives: 3,
  score: 0
}
@player_2 = {
  name: "",
  lives: 3,
  score: 0
}

@answer = 0.0

# Asks player 1 and player 2 for names and stores names in :name key of @player hash
def prompt_player_for_name
  puts "What is player 1's name?"
  @player_1[:name] = gets.chomp.to_s
  puts "What is player 2's name?"
  @player_2[:name] = gets.chomp.to_s
end

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

# Given a player, asks that player the question created by generate_question and stores answer in @player_answer
def prompt_player_for_answer(player)
  puts "#{player}".colorize(:underline).underline + ": #{@question}"
  @player_answer = gets.chomp.to_i
end

# Given a player, checks if the answer provited by that player is equal to the actual answer and returns true or false accordingly
def verify_answer(player)
  @player_answer == @answer ? true : false
end

# Given a player, calls generate question to get @question, then calls prompt player for answer to get @player_answer, then calls verify_answer to check of @player_answer is correct. If @player_answer is correct, puts "Correct" and returns the altered scores and lives of each player.
def play_round(player)
  generate_question
  prompt_player_for_answer(player)
  verify_answer(player)
  if verify_answer(player)
    puts "Correct!".colorize(:green)
    player == "#{@player_1[:name]}" ? @player_1[:score] += 1 : @player_2[:score] += 1
  else
    puts "Incorrect.".colorize(:red)
    player == "#{@player_1[:name]}" ? @player_1[:lives] -= 1 : @player_2[:lives] -= 1
  end
end

# Checks the :lives of @player_1 and @player_2 to determine who won the game or if there was a tie. Displays the winner of the most recent game as well as the total scores of each player.
def display_results
  if @player_1[:lives] == 0 && @player_2[:lives] == 0
    puts "Tie!"
  elsif @player_2[:lives] == 0
    puts "#{@player_1[:name]} won the round!"
  else
    puts "#{@player_2[:name]} won the round!"
  end

  puts "Total Scores"
  puts "#{@player_1[:name]}: #{@player_1[:score]}"
  puts "#{@player_2[:name]}: #{@player_2[:score]}"
end

# Checks the :lives of @player_1 and @player_2 to determine if the game is over or if another round of questions should be displayed. Calls play_round if :lives of both players is not zero. 
def play_game
  while @player_1[:lives] != 0 && @player_2[:lives] != 0
    play_round("#{@player_1[:name]}")
    play_round("#{@player_2[:name]}")
  end

  display_results
  play_again?
end

# Asks the player for input to determine if they would like to replay the game or exit.
def play_again?  
  puts "Do you want to play again? (yes or no)"
  @play_again = gets.chomp.to_s

  if @play_again == 'yes'
    @player_1[:lives] = 3
    @player_2[:lives] = 3
    play_game
  else
  end
end

prompt_player_for_name
play_game