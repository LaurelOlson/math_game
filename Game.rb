class Game
  attr_reader :num_players, :players, :games_played
  def initialize(n, players)
    @num_players = n
    @players = players
    @games_played = 0
  end

  # Checks the lives of player[n] to determine who won the game or if there waas a tie.
  # Displays the winner of the most recent game as well as the total scores of each player.
  def results(players)
    potential_winners = players.find_all { |player| player.lives != 0 }.sort { |x, y| y.score <=> x.score }

    if potential_winners.empty? # Either all players got zero or all players got the same score
      if players.find_all { |player| player.score != 0 }.empty?
        puts "Everyone lost! :("
      else 
        puts "#{@num_players}-way tie!"
      end
    elsif potential_winners.length == 1 # Only one potential winner so must be the overall winner
      puts "#{potential_winners[0].name} won the round!"
    elsif potential_winners[0].score == potential_winners[1].score # Tie between one ore more players - need to check how many players
      top_score = potential_winners[0].score
      winners_names = potential_winners.find_all { |players| players.score == top_score }.map { |player| player.name }
      puts "Tie between #{winners_names.join(" and ")}!"
    else
    end

    puts "Total Scores"
    players.each { |player| puts "#{player.name}: #{player.score}" }
  end

  # Checks the lives of all players to determine if the game is over or if another round of questions should be displayed. 
  def game_over?
    lives = lives = players.collect { |player| player.lives != 0 }
    lives.include? false
  end

  # Until game_over? is true, creates a new Question instance and Round instance for each player, then plays a round. 
  # Displays results.
  # Updates games_played.
  # Calls play_again to determine if the game can/should be played again.
  def play(game, players, games_played)
    until game_over?
      players.each do |player| 
        question = Question.new(1, 20)
        Round.new(player, question).play(player, question)
      end
      lives = players.collect { |player| player.lives != 0 }
    end

    results(players)
    games_played += 1
    play_again(game, players, games_played)
  end

  # Checks if player can play again (if less than max number of games has been played)
  def can_play_again?(games_played)
    games_played < 5
  end

  # If can_play_again? is true, asks if the player(s) want to play again.
  # If can_play_again? is false, tells the player(s) to take a break and exits the program.
  def wants_to_play_again?(games_played)
    if can_play_again?(games_played)
      puts "Do you want to play again? (yes or no)"
      play_again = gets.chomp
      play_again == 'yes'
    else
      puts "Time to take a break!"
    end
  end

  # If the player wants to play again, resets scores and lives of each player and then calls game.play to initiate a new game.
  def play_again(game, players, games_played)
    if wants_to_play_again?(games_played)
      players.each do |player|
        player.reset_lives
        player.reset_score
      end
      game.play(game, players, games_played)
    end
  end

end
