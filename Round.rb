# Inherits @num_players, @players, and @games_played from Game

class Round < Game
  def initialize(question, player)
    @question = question
    @player = player
  end

  # Takes two arguments: players[n] and a randomly generated question (Question.new(1..20)). 
  # Puts the string interpoloation of players[n].name plus the question instance created by Question.new(1..20), then asks for user input.
  # Stores user input in player[n].answer. 
  # If both arguments are not passed, NoArgument Error.
  def prompt_player_for_answer(player, question)
    puts "#{player.name}".colorize(:underline).underline + ": #{question.question}"
    player.answer = gets.chomp.to_i
  end

  # Checks if player_answer is equal to the actual answer and returns true or false accordingly
  def player_correct?(player, question)
    player.answer == question.answer
  end

  # Takes two arguments: players[n] and a randomly generated question (Question.new(1..20)). 
  # Calls prompt player for answer to get player[n].answer.
  # If the player is correct, puts "Correct" and player[n] gains a point.
  # If the player is incorect, puts "Incorrect" and player[n] loses a life.
  # If both arguments are not passed, NoArgument Error.
  def play(player, question)
    prompt_player_for_answer(player, question)
    if player_correct?(player, question)
      puts "Correct!".colorize(:green)
      player.gain_point
    else
      puts "Incorrect.".colorize(:red)
      player.lose_life
    end
  end
end
