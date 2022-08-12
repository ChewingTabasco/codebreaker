module Maker
  def generate_random_code
    random_code = [(1 + rand(6)), (1 + rand(6)), (1 + rand(6)), (1 + rand(6))]
  end
end

class Game
  extend Maker
end

p Game.generate_random_code
