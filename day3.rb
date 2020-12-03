@input = File.open('inputs/day3_input.txt')
@grid = []
@input.each { |line| @grid += [line.chomp()]}
@grid_size_x = @grid.first.length
@grid_size_y = @grid.count

def traverse_slope(right_steps, down_steps)
    x = y = tree_counter = 0
    (@grid_size_y / down_steps).times do |i|
        tree_counter += 1 if @grid[y][x % @grid_size_x].eql?('#')
        x += right_steps
        y += down_steps
    end
    return tree_counter
end

part2 = traverse_slope(1,1) * traverse_slope(3,1) * traverse_slope(5,1) * traverse_slope(7,1) * traverse_slope(1,2)
puts "Part 1: #{traverse_slope(3,1)} || Part 2: #{part2}"