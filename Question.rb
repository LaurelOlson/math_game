require 'colorize'

class Question
  attr_reader :question, :answer

  def initialize(min, max)
    @num_1 = rand(min..max)
    @num_2 = rand(min..max)
    @operator = ['add', 'subtract', 'multiply'].sample

    case @operator
    when 'add'
      @question = "What is the " + "sum".colorize(:bold).bold + " of #{@num_1} and #{@num_2}?"
      @answer = @num_1 + @num_2
    when 'subtract'
      @answer = @num_1 - @num_2
      @question = "What is the " + "difference".colorize(:bold).bold + " between #{@num_1} and #{@num_2}?"
    when 'multiply'
      @answer = @num_1 * @num_2
      @question = "What is the " + "product".colorize(:bold).bold + " of #{@num_1} and #{@num_2}?"  
    else
    end
  end
end
