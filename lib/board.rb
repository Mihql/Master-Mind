# frozen_string_literal: true

# Class Board
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

  def update; end
end