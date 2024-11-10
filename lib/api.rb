# frozen_string_literal: true

require 'color'

# Class API: Valid check, Include check, Display Interface
class API
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

  def send_client_message(status)
    case status
    when :winning_combination
      "Choose #{@max_guess} color from #{@game.computer_color_guess} guesses: #{@game.player_guess}/#{@max_guess}"
    when :Jackpot
      "Jackpot you won with winning combination of #{color_arr_main} with #{@max_guess} max guess"
    else 
      "Choose #{@max_guess} color from #{@game.computer_color_guess} guesses: #{@game.player_guess}/#{@max_guess}"
    end
  end

  def ask_user_prompt_color(color_arr)
    loop do
      user_prompted_color = gets.chomp
      color_arr << user_prompted_color if valid_input?(user_prompted_color)
      return user_prompted_color, color_arr if valid_input?(user_prompted_color)

      puts 'retry again wrong format'
    end
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
      return message = "Jackpot you won with winning combination of #{color_arr_main} with #{@max_guess} max guess"
    end

    if combination_code == color_arr_main || combination_code.sort == color_arr_main.sort
      @game.player_guessed_level_right += 1
      message = "Congrates Color-Set #{color_arr_main} found on the winning combination, move on now try find correct"
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
