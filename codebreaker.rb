module Maker
  attr_reader :maker_code
  def generate_random_code
    @maker_code = [(1 + rand(6)), (1 + rand(6)), (1 + rand(6)), (1 + rand(6))]
  end

  def create_code
    puts 'Maker, create a 4 digit code (1-6).'
    @maker_code = gets.chomp.split('').map { |num| num.to_i}
  end
end

module Breaker
  def make_guess
    puts 'Breaker, make a 4 digit guess (1-6)'
    @breaker_guess = gets.chomp.split('').map { |num| num.to_i}
  end
end

class Game
  def initialize(maker, breaker)
    @maker = maker
    @breaker = breaker
  end

  def play_round
    @maker.generate_random_code
    p @maker.maker_code
    p @breaker.make_guess
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

# ---------------------------------------------------------

computer = Computer.new
# computer.generate_random_code
# p computer.maker_code

player = Player.new
# player.create_code
# p player.maker_code
# p player.make_guess

game = Game.new(computer, player)
game.play_round
