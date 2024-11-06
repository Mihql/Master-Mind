# frozen_string_literal: true

# Class Board: Display, Manages the grid
class Board
  def initialize
    @grid_one = Array.new(4) { Array.new(4, 'o') }
    @entered_grid = []
  end

  def display_board
    @grid_one.each_with_index do |row, row_index|
      puts "Row:#{row_index} = #{row}"
    end
  end

  def update(player_guessed_color_code, level, row)
    puts "level:#{level} row:#{row}"
    @grid_one[level][row] = player_guessed_color_code
  end
end
