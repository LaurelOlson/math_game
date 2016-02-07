require 'pry'
require 'colorize'
require './Game'
require './Round'
require './player'
require './question'
require 'active_support/all'

puts "How many players are there?"
n = gets.chomp.to_i
players = []
n.times do |i|
  puts "What is player #{i+1}'s name?"
  players[i] = Player.new(gets.chomp.to_s)
end

game = Game.new(n, players)

game.play(game, players, game.games_played)

