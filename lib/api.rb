# frozen_string_literal: true

require 'color'

require_relative './enum_module'

# Class API: Valid check, Include check, Display Interface
class API
  include PlayerRole
  def initialize(board, game, config_game)
    @board = board
    @game = game
    @max_guess = config_game['max_guess']
    @count = config_game['count']
  end

  ## API Valid Include check
  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  def send_status_message(color_main, status)
    case status
    when :winning_combination
      puts "Congrates Color-Set #{color_main} found on the winning combination, move on now try find correct"
    when :jackpot
      puts "Jackpot you won with winning combination of #{color_main} with #{@max_guess} max guess"
    when :normal 
      puts "Choose #{@max_guess} color from #{@game.computer_color_guess} guesses: #{@game.player_guess}/#{@max_guess}"
    end
  end

   # Create aliases for the methods alias scm
   alias SSM send_status_message

  def return_player_role
    role = gets.chomp.downcase
    case role
    when "player"
      PlayerRole::PLAYER
    when "playmaker"
      PlayerRole::PLAY_MAKER
    else
      puts "Invalid role. Please enter 'player' or 'playmaker'."
      return_player_role
    end
  end

  def choose_color_code
    color_code = []
    @max_guess.times do |g|
      puts "Enter color codes #{g}/#{@max_guess}"
      color = validate_color(color)
      p color_code << color
    end
    color_code
  end

  def validate_color(color)
    loop do
      color = ask_user_prompt_color(color)
      return color if valid_input?(color)
      puts "Retry wrong format"
    end
  end
  
  def ask_user_prompt_color(color_arr)
    user_prompted_color = gets.chomp
  end

  def new_computer_guess_code
    @game.computer_color_guess.sample(4)
  end

  def check_color_at_index(color, combination_code, index)
    return "Great you found #{color} of combination color" if combination_code[index].include?(color)

    message = if combination_code.include?(color)
                "Unfortunately thats not winning combination / but #{color} where in the combination"
              else
                'Unfortunately nothing found'
              end

    [message]
  end

  def check_color_arr_at_combination(color_arr_main, combination_code)
    if combination_code == color_arr_main
      return send_status_message(color_arr_main, :jackpot), :success
    end

    if combination_code == color_arr_main || combination_code.sort == color_arr_main.sort
      @game.player_guessed_level_right += 1
      message = send_status_message(color_arr_main, :winning_combination)
    else
      message = 'Try again'
    end
    message
  end

  def color_in_computer_code?(color)
    @game.computer_color_guessed_code.include?(color)
  end

  def valid_input?(user_input)
    user_input.is_a?(String) && valid_color_name?(user_input)
  end

  # Display
  def display_feedback(color)
    puts "You guessed #{color}: #{@game.player_guessed_each_right} correct out of / 5"
  end

  def add_guess_to_board(color, level, row)
    @board.update(color, level, row)
  end

  def display_board
    @board.display_board
  end
end
