class Player
  attr_accessor :name, :score, :lives, :answer

  def initialize(name, max_life)
    @name = name
    @score = 0
    @lives = max_life
    @answer = ""
  end

  def gain_point
    @score += 1
  end

  def lose_life
    @lives -= 1
  end

  def reset_lives
    @lives = max_life
  end
end