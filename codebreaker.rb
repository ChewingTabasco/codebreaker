module Maker
  attr_reader :maker_code
  
  def generate_random_code
    @maker_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
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
    exact_matches = []
    @master_code = maker.maker_code

    # Pushes the values of the user's guesses that match the maker code values at the same index
    @breaker_guess.each.with_index do |guess_num, guess_index|
      if guess_num == @master_code[guess_index]
        exact_matches.push(guess_num)
      end
    end

    # Remove exact matches from both the maker & the breaker arrays to prevent them being counted again in the next step
    exact_matches.each do |num|
      @master_code.delete_at(@master_code.index(num))
      p @master_code
      @breaker_guess.delete_at(@breaker_guess.index(num))
      p @breaker_guess
    end

    # This is an intersection of two arrays that also includes duplicate numbers
    close_matches = ((@master_code & @breaker_guess).flat_map { |n| [n] * [@master_code.count(n), @breaker_guess.count(n)].min })

    puts "#{exact_matches.size} match(es) in your guess are the correct number in the correct position."
    puts "#{close_matches.size} match(es) in your guess are the correct number in the incorrect position."
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
