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

module Breaker
  def make_guess
    puts 'Breaker, make a 4 digit guess (1-6)'
    @breaker_guess = gets.chomp.split('')
  end
end

class Game
  def initialize(maker, breaker)
    @maker = maker
    @breaker = breaker
  end
end

class Player
  include Maker, Breaker

  def initialize; end
end

class Computer
  include Maker, Breaker

  def initialize; end
end

player = Player.new
player.create_code
p player.maker_code

p player.make_guess
