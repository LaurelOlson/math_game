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

#binding.pry
def play_game
  while @player_1[:lives] != 0 && @player_2[:lives] != 0
    prompt_player_for_answer('Player 1')
    verify_answer('Player 1')
    if verify_answer('Player 1')
      puts "Correct!"
      @player_1[:score] += 1
    else
      puts "Incorrect."
      @player_1[:lives] -= 1
    end

    prompt_player_for_answer('Player 2')
    verify_answer('Player 2')
    if verify_answer('Player 2')
      puts "Correct!"
      @player_2[:score] += 1
    else
      puts "Incorrect."
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



