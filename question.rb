require 'colorize'

class Question
  attr_accessor :num_1, :num_2, :operator
  attr_reader :question, :answer

  def initialize(num_1, num_2, operator)
    @num_1 = num_1
    @num_2 = num_2
    @operator = operator
  end

  def addition_question
    @answer = @num_1 + @num_2
    @question = "What is the " + "sum".colorize(:bold).bold + " of #{@num_1} and #{@num_2}?"
  end

  def subtraction_question
    @answer = @num_1 - @num_2
    @question = "What is the " + "difference".colorize(:bold).bold + " between #{@num_1} and #{@num_2}?"
  end

  def multiplication_question
    @answer = @num_1 * @num_2
    @question = "What is the " + "product".colorize(:bold).bold + " of #{@num_1} and #{@num_2}?"  
  end
end