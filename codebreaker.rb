module Maker
  attr_reader :maker_code
  def generate_random_code
    random_code = [(1 + rand(6)), (1 + rand(6)), (1 + rand(6)), (1 + rand(6))]
  end

  def create_code
    puts 'Maker, create a 4 digit code (1-6).'
    @maker_code = gets.chomp.split('')
  end
end

class Game
  extend Maker

  def initialize(maker, breaker)
    @maker = maker
    @breaker = breaker
  end
end

class Player
  include Maker

  def initialize; end
end

p Game.generate_random_code

player = Player.new
player.create_code
p player.maker_code
