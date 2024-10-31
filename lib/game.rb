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

    @computer_color_code = load_color
    @computer_guessed_code = @computer_color_code['colors'].keys.sample(4)
    puts "#{@computer_guessed_code}  - COMPUTER GUESSED CODE"

    @computer = 'O'
    @player = 'X'
    @level = 0
    @player_guessed_right = 0
    @guessed_color_code = Array.new(COUNT) { Array.new(COUNT) }
  end

  def load_color
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

  private

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

        break if auth_check?(user_input, i)

        # Break out the inner loop

        puts "invalid color input #{user_input}"
        # The loop will repeat, allowing user to try again without losing current slot
      end
    end

    @level += 1
  end

  def auth_check?(user_input, iterate)
    if user_input.is_a?(String) && valid_color_name?(user_input)

      Color::RGB.by_name(user_input).html.upcase # covert to hex

      puts "#{@computer_guessed_code}  - COMPUTER GUESSED CODE"
      @guessed_color_code[@level][iterate] = user_input # "color_name"

      add_guess(user_input, @level, iterate)
      @board.display_board
      level(user_input)
      puts "Goblin lord"
      true
    else
      false
    end
  end

  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
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

  def add_guess(player_guessed_color_code, level, row)
    @board.update(player_guessed_color_code, level, row)
  end
end

Game.new.play
