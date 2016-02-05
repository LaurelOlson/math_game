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

# Generates a simple addition question by picking two random numbers between 1 and 20 
def generate_question
  num_1 = Random.new
  num_1 = num_1.rand(1.0..20.0).floor

  num_2 = Random.new
  num_2 = num_2.rand(1.0..20.0).floor

  if @operation == 'add'
    @answer = num_1 + num_2
    @question = "What is the sum of #{num_1} and #{num_2}?"
  elsif @operation == 'subtract'
    @answer = num_1 - num_2
    @question = "What is the difference between #{num_1} and #{num_2}?"
  elsif @operation == 'multiply'
    @answer = num_1 * num_2
    @question = "What is the product of #{num_1} and #{num_2}?"
  else
    puts "That is not a valid operation. Please choose again."
    play_game
  end
end

def prompt_player_for_name
  puts "What is player 1's name?"
  @player_1[:name] = gets.chomp.to_s
  puts "What is player 2's name?"
  @player_2[:name] = gets.chomp.to_s
end

def prompt_player_for_operation
  puts "Would you like to add, subtract, or multiply?"
  @operation = gets.chomp.to_s
end

def prompt_player_for_answer(player)
  puts "#{player}: #{@question}"
  @player_answer = gets.chomp.to_i
end

def verify_answer(player)
  @player_answer == @answer ? true : false
end

def ask_question(player)
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

def display_results
  if @player_1[:lives] == 0 && @player_2[:lives] == 0
    puts "Tie!"
  elsif @player_2[:lives] == 0
    puts "#{@player_1[:name]} is the winner!"
  else
    puts "#{@player_2[:name]} is the winner!"
  end

  puts "Total Scores"
  puts "#{@player_1[:name]}: #{@player_1[:score]}"
  puts "#{@player_2[:name]}: #{@player_2[:score]}"
end

#binding.pry
def play_game

  prompt_player_for_operation

  while @player_1[:lives] != 0 && @player_2[:lives] != 0
    ask_question("#{@player_1[:name]}")
    ask_question("#{@player_2[:name]}")
  end

  display_results
  play_again?
end

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

# binding.pry
prompt_player_for_name
play_game