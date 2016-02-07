class Game
  attr_reader :num_players, :players, :games_played
  def initialize(n, players)
    @num_players = n
    @players = players
    @games_played = 0
  end

  # Checks the lives of player[n] to determine who won the game or if there was a tie.
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
  # While the lives of all players is not zero, creates a new Question instance and Round instance for each player, then plays a round. 
  # Displays results.
  # Updates games_played.
  # If less than 5 rounds have been played, asks if the player(s) want(s) to play again and responds accordingly.
  # If 5 rounds have been played, tells the player(s) to take a break and exits the program.
  def play(game, players, games_played)
    lives = players.collect { |player| player.lives != 0 }
    while lives.exclude? false
      players.each do |player| 
        question = Question.new(1, 20)
        Round.new(player, question).play(player, question)
      end
      lives = players.collect { |player| player.lives != 0 }
    end

    results(players)

    games_played += 1

    if games_played < 5
      puts "Do you want to play again? (yes or no)"
      play_again = gets.chomp.to_s
    else
      puts "Time to take a break!"
    end
    if play_again == 'yes'
      players.each do |player|
        player.reset_lives
        player.reset_score
      end
      game.play(game, players, games_played)
    else
    end
  end
end