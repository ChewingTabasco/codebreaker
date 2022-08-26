# frozen_string_literal: true

require 'colorize'

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
  attr_reader :breaker_guess, :exact_matches

  def make_guess
    puts 'Breaker, make a 4 digit guess (1-6)'
    @breaker_guess = gets.chomp.split('').map(&:to_i)

    if !@breaker_guess.all?(1..6) || @breaker_guess.size != 4
      puts 'Your guess must contain four numbers between 1 and 6.'
      make_guess
    end
  end

  def get_auto_feedback(maker)
    master_code = maker.maker_code
    @exact_matches = @breaker_guess.select.with_index { |num, index| num == master_code[index] }
    remaining_master_values = master_code.select.with_index { |num, index| num != @breaker_guess[index] }
    remaining_guess_values = @breaker_guess.select.with_index { |num, index| num != master_code[index] }

    # This is an intersection of two arrays that also includes duplicate numbers
    # (all values that match, but are at different indexes)
    close_matches = ((remaining_master_values & remaining_guess_values).flat_map do |n|
      [n] * [remaining_master_values.count(n), remaining_guess_values.count(n)].min
    end)

    print_feedback(@exact_matches, close_matches)
  end

  def print_feedback(exact_match, close_match)
    puts "#{Array.new(exact_match.size, '●').join(' ')} #{Array.new(close_match.size, '○').join(' ')}"
  end
end

class Game
  # create a set maker/breaker method to call in here

  def initialize(maker, breaker)
    @maker = maker
    @breaker = breaker
  end

  def self.print_instructions
    inst_game = Game.new(nil, nil)
    puts '
    Welcome to Codebreaker!

    -----------------------------

    There are 2 players in this game: The CODEMAKER and the CODEBREAKER.

    You will decide which side you would like to play. The other side
    will be played by the computer.

    The CODEMAKER will create a secret code of four colors. The CODEBREAKER
    will have 12 chances to guess the correct code. If the CODEBREAKER does
    not guess correctly within 12 rounds, the CODEMAKER wins.

    There are 6 different colors to choose from, each represented by a
    number (1 - 6):
    '
    print '    '
    inst_game.print_in_color((1..6))
    puts '

    The CODEBREAKER will make 4 digit guesses using numbers to represent the
    corresponding colors.

    The CODEMAKER will judge the provided guesses with symbols representing
    exact matches and close matches.

      - An exact match is a color/number in the CODEBREAKER guess that is in
      the same position in the secret code.

      - A close match is a color/number in the CODEBREAKER guess that is
      found in the secret code, but is not in the correct position.

    When you are playing as the CODEBREAKER, your guess will be printed in
    the console along with the symbols representing any of your matches (if
    any exist).

    ● = Exact Match   ○ = Close Match

      * The position of the dots DO NOT represent the position of your match.

    The secret code can contain repeat colors or even be four of the same
    color.

    '
  end

  def play_round
    @breaker.make_guess
    print_in_color(@breaker.breaker_guess)

    @breaker.get_auto_feedback(@maker)
  end

  def play_game
    round_count = 1

    puts 'Codebreaker, you must crack the secret code before its too late!'

    while round_count <= 12
      puts "Round ##{round_count}"
      play_round
      round_count += 1
      break if @breaker.exact_matches.size >= 4
    end

    if @breaker.exact_matches.size >= 4
      puts "Congratulations Codebreaker! You've cracked the secret code!"
    else
      print 'The Codemaker has bested you... The code was: '
      print_in_color(@maker.maker_code)
      puts ' '
    end
  end

  def print_in_color(code)
    colors = %i[light_red yellow light_yellow light_green light_blue light_magenta]
    code.each do |num|
      print " #{num} ".colorize(:color => :black, :background => colors[num - 1]) + ' '
    end
  end
end

class Player
  include Maker
  include Breaker

  def initialize; end
end

class Computer
  include Maker
  include Breaker

  def initialize; end
end

# ---------------------------------------------------------

computer = Computer.new
player = Player.new

Game.print_instructions

game = Game.new(computer, player)
computer.generate_random_code
game.play_game
