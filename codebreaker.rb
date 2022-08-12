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
end

p Game.generate_random_code
Game.create_code
p Game.maker_code