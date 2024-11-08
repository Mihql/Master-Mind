# frozen_string_literal: true

require_relative './lib/game'

# Class Crank: Crank Initial
class Crank
  def initialize(game)
    @game = game
  end

  def play
    4.times do
      @game.prompt_for_guess
    end

    puts "Guessed color codes are: #{@guessed_color_code}"
  end
end
