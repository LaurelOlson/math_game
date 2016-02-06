require 'pry'
require 'colorize'
require './player'
require './question'

puts "How many players are there?"
n = gets.chomp.to_i
players = []
n.times do |i|
  puts "What is player #{i+1}'s name?"
  players[i] = Player.new(gets.chomp.to_s, 3)
end

# Takes players[n] as an argument. 
# Puts the string interpoloation of @player_n.name plus the question created by generate_question, then asks for user input.
# Stores user input in player[n].answer. 
# If no argument is passed, NoArgument Error (0 for 1).
def prompt_player_for_answer(player, question)
  puts "#{player.name}".colorize(:underline).underline + ": #{question.question}"
  player.answer = gets.chomp.to_i
end

# Checks if player_answer is equal to the actual answer and returns true or false accordingly
def player_correct?(player, question)
  player.answer == question.answer
end

# Takes player[n] as an argument. 
# Calls generate question to get @question, then calls prompt player for answer to get @player_answer, then calls verify_answer to check if @player_answer is correct. If @player_answer is correct, puts "Correct" and returns the altered scores and lives of each player.
# If no argument is passed, NoArgument Error (0 for 1).
def play_round(player, question)
  prompt_player_for_answer(player, question)
  if player_correct?(player, question)
    puts "Correct!".colorize(:green)
    player.gain_point
  else
    puts "Incorrect.".colorize(:red)
    player.lose_life
  end
end

# Checks the lives of player[n] to determine who won the game or if there was a tie.
# Displays the winner of the most recent game as well as the total scores of each player.
def display_results(players)
  players.each do |player|
    if player.lives != 0 
      puts "#{player.name} won the round!"
    end
  end

  puts "Total Scores"
  players.each do |player|
    puts "#{player.name}: #{player.score}"
  end
end

# Checks the lives of all players to determine if the game is over or if another round of questions should be displayed. 
# Calls play_round if lives of all players is not zero. 
# Calls display_results, then play_again if the lives all players is zero.
def play_game(players)
  lives = players.collect do |player|
    player.lives != 0 
  end

  while (lives.include? (true)) && (lives.uniq.length == 1)
    players.each do |player|
      play_round(player, Question.new(1, 20))
    end
    lives = players.collect do |player|
    player.lives != 0 
  end
  end

  display_results(players)
  
  puts "Do you want to play again? (yes or no)"
  play_again = gets.chomp.to_s

  if play_again == 'yes'
    players.each do |player|
      player.reset_lives
      player.reset_score
    end
    play_game(players, question)
  else
  end
end

play_game(players)