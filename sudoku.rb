sudoku_puzzle = [
    [0,3,2,0,0,0,4,0,0],
    [0,4,8,0,2,7,9,5,0],
    [0,0,0,0,8,0,0,7,0],
    [8,0,0,0,0,9,5,3,4],
    [6,0,0,8,0,3,0,0,0],
    [0,0,4,0,0,0,0,0,0],
    [0,6,0,0,9,8,7,4,5],
    [0,7,0,0,6,0,0,0,2],
    [0,0,5,0,3,0,0,0,0],
]


class Sudoku
    def initialize(puzzle)
      @puzzle = puzzle
    end

    attr_reader :puzzle

    BOX_BOUNDS = {
        0 => [0,1,2],
        1 => [0,1,2],
        2 => [0,1,2],
        3 => [3,4,5],
        4 => [3,4,5],
        5 => [3,4,5],
        6 => [6,7,8],
        7 => [6,7,8],
        8 => [6,7,8],
    }.freeze

    def show
        pp puzzle
    end
    
    def complete?
        puzzle.flatten.none?(&:zero?)
    end

    def solve!
        while !complete?
            @puzzle.each_with_index do |row, row_index|
                row.each_with_index do |number, number_index|
                    if number.zero?
                        row[number_index] = 1

                        horizontal_values = row
                        vertical_values = puzzle.map { |puzzle_row| puzzle_row[number_index] } 
                        box_values = box_values(row_index, number_index)

                        all_values = (horizontal_values + vertical_values + box_values).reject(&:zero?).uniq
                        potencial_values = (1..9).to_a - all_values
                        if potencial_values.size == 1
                            row[number_index] = potencial_values.first
                        end
                        
                    end
                end
            end
        end
    end
    
    private
    
    def box_values(row_index, number_index)
        row_indexes = BOX_BOUNDS[row_index]
        number_indexes = BOX_BOUNDS[number_index]

        values = []

        
        row_indexes.each do |r_index|
            number_indexes.each_with_index do |n_index|
                values << puzzle[r_index][n_index]
            end
        end
        
    end
    
end


game = Sudoku.new(sudoku_puzzle)

game.show

game.solve!

game.show