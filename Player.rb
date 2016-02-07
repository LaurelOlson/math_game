class Player
  attr_reader :name, :lives, :score
  attr_accessor :answer

  def initialize(name)
    @name = name
    @score = 0
    @lives = 3
    @answer = ""
  end

  def gain_point
    @score += 1
  end

  def lose_life
    @lives -= 1
  end

  def reset_lives
    @lives = 3
  end

  def reset_score
    @score = 0
  end
end
