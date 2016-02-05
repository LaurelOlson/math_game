require 'pry'
require 'colorize'

@player_1 = {
  lives: 3,
  score: 0
}
@player_2 = {
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
  @answer = num_1 + num_2
  question = "What is the sum of #{num_1} and #{num_2}?"
end

def prompt_player_for_answer(player)
  puts "#{player}: #{generate_question}"
  @player_answer = gets.chomp.to_i
end

def verify_answer(player)
  @player_answer == @answer ? true : false
end

def play_round(player)
  prompt_player_for_answer(player)
  verify_answer(player)
  if verify_answer(player)
    puts "Correct!"
    @winner = player
  else
    puts "Incorrect."
  end
end

#binding.pry
def play_game
  while @player_1[:lives] != 0 && @player_2[:lives] != 0
    play_round('Player 1')
    if @winner == 'Player 1'
      @player_1[:score] += 1
    else
      @player_1[:lives] -= 1
    end

    play_round('Player 2')
    if @winner == 'Player 2'
      @player_2[:score] += 1
    else
      @player_2[:lives] -= 1
    end
  end

  if @player_1[:lives] == 0
    puts "Player 2 is the winner with a score of #{@player_2[:score]}!"
    puts "Player 1 finished with a score of #{@player_1[:score]}"
  else
    puts "Player 1 is the winner with a score of #{@player_1[:score]}!"
    puts "Player 2 finished with a score of #{@player_2[:score]}"
  end

end

play_game