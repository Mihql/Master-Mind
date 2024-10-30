# frozen_string_literal: true

require_relative 'board'
require_relative 'color_loader'
require 'color'

# Class Game
class Game
  COUNT = 4
  COLOR_INFO = Array.new(COUNT)

  def initialize
    @board = Board.new
    @color_loader = ColorLoader.new

    @computer_color_code = generate_random_color(COUNT)
    @guessed_color_code = Array.new(COUNT) { Array.new(COUNT) }
    @computer_guessed_code = @computer_color_code['colors'].keys.sample(4)
    puts "#{@computer_guessed_code}  - COMPUTER GUESSED CODE"
    @computer = 'O'
    @player = 'X'
    @level = 0 # Initial -1 because increment array
    @player_guessed_right = 0
  end

  def generate_random_color(_count)
    puts @color_loader.color_info
    @color_loader.color_info
  end

  def play
    COUNT.times do
      @board.display_board
      # result_boolean = level()
      prompt_color
    end

    @board.display_board
    puts "Guessed color codes are: #{@guessed_color_code}"
  end

  def level(user_input)
    result = get_computer_guess_color(user_input)
    puts "Lets see the #{result.last}"
    if result.last
      color = result[0]
      puts "#{color} You Found It !!!"
      @player_guessed_right += 1
    else
      puts "DUMB!!! #{user_input} is not here!"
    end

    feedback(user_input, @player_guessed_right)
  end

  def feedback(color, player_guessed_right)
    puts "You guessed #{color} of #{player_guessed_right} / 5"
  end

  def prompt_color
    COUNT.times do |i|
      loop do
        puts 'Choose the colors you wants guess:'
        user_input = gets.chomp

        if user_input.is_a?(String) && valid_color_name?(user_input)
          Color::RGB.by_name(user_input).html.upcase # covert to hex
          # @guessed_color_code[@level][i] = colored        #// hex
          @guessed_color_code[@level][i] = user_input # "color_name"
          add_guess(user_input, @level, i)
          @board.display_board

          level(user_input)
          puts 'ITS BREAK HERE NO WONDERS!'
          puts "#{@computer_guessed_code}  - COMPUTER CODE"
          break # Break out the inner loop
        else
          puts "invalid color input #{user_input}"
          # The loop will repeat, allowing user to try again without losing current slot
        end
      end
    end

    @level += 1
    puts 'DOES IT BREAK?'
    level(@guessed_color_code)
  end

  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  def get_guess_color(color)
    @computer_color_code.each do |color_name, color_hex|
      if color_hex == color
        puts "Color-Hex: #{color_hex} | Color-name: #{color_name} | Color: #{color}"
        return [color, true]
      end
    end

    [color, false]
  end

  def get_computer_guess_color(color)
    @computer_guessed_code.each do |color_key|
      if color_key == color
        puts "#{color_key} == #{color}"
        return [color, true]
      end
    end

    [color, false]
  end

  def add_guess(guessed_color_code, level, column)
    @board.update(guessed_color_code, level, column)
  end
end

Game.new.play
