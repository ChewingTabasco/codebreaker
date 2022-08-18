module Maker
  attr_reader :maker_code
  def generate_random_code
    @maker_code = [(1 + rand(6)), (1 + rand(6)), (1 + rand(6)), (1 + rand(6))]
  end

  def create_code
    puts 'Maker, create a 4 digit code (1-6).'
    @maker_code = gets.chomp.split('').map(&:to_i).take(4)
  end
end

module Breaker
  attr_reader :breaker_guess

  def make_guess
    puts 'Breaker, make a 4 digit guess (1-6)'
    @breaker_guess = gets.chomp.split('').map(&:to_i).take(4)
  end

  def get_auto_feedback(maker)
    @maker = maker
    @guesses_copy = @breaker_guess
    @perf_matches = []
    @match_indexes = []
    @value_matches = []
    @master_code = @maker.maker_code

    @guesses_copy.each.with_index do |guess_num, guess_index|
      if guess_num == @master_code[guess_index]
        @perf_matches.push(guess_num)
        @match_indexes.push(guess_index)
      end
    end

    @match_indexes.each do |i|
      @master_code.delete_at(i)
      @guesses_copy.delete_at(i)
    end

    p "master code = #{@master_code}"
    p "guesses copy = #{@guesses_copy}"

    @guesses_copy.each do |number|
      if @master_code.include?(number)
        @value_matches.push(number)
        @master_code.delete_at(@master_code.index(number))
        p "master_str = #{@master_code}"
      end
    end

    p @perf_matches
    puts "#{@perf_matches.size} match(es) in your guess are the correct number in the correct position."
    p @value_matches
    puts "#{@value_matches.size} match(es) in your guess are the correct number in the incorrect position."

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

    @breaker.get_auto_feedback(@maker)
    
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
