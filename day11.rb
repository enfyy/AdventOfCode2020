@input = File.open('inputs/day11_input.txt').read.split("\n").map { |line| line.split("") } # seats[row][col] = seat y x

def part1()
  @seats = @input.map(&:dup)
  until rules_part1() == 0
  end
  count = 0
  @seats.each { |row| count += row.count('#') }
  count
end

def part2()
  @seats = @input.map(&:dup)
  until rules_part2() == 0 
  end
  count = 0
  @seats.each { |row| count += row.count('#') }
  count
end

def rules_part1()
  changes = 0
  new_state = @seats.map(&:dup)
  @seats.each_with_index do |row, r|
    row.each_with_index do |seat, c|
      if seat.eql?('L') && occupied_adjacent_seats_part1(r, c) == 0
        new_state[r][c] = '#'
        changes += 1
        next
      end
      if seat.eql?('#') && occupied_adjacent_seats_part1(r, c) > 3
        new_state[r][c] = 'L'
        changes += 1
        next
      end
    end
  end
  @seats = new_state.map(&:dup)
  return changes
end

def rules_part2()
  changes = 0
  new_state = @seats.map(&:dup)
  @seats.each_with_index do |row, r|
    row.each_with_index do |seat, c|
      if seat.eql?('L') && occupied_adjacent_seats_part2(r, c) == 0
        new_state[r][c] = '#'
        changes += 1
        next
      end
      if seat.eql?('#') && occupied_adjacent_seats_part2(r, c) > 4
        new_state[r][c] = 'L'
        changes += 1
        next
      end
    end
  end
  @seats = new_state.map(&:dup)
  return changes
end

def occupied_adjacent_seats_part1(r, c)
  count = 0
  offsets = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]]
  offsets.each do |offset|
    y = r + offset[0]
    x = c + offset[1]
    next if x.negative? || y.negative? || x >= @input.first.count || y >= @input.count
    seat = @seats.dig(y, x)
    next if seat.nil?
    count += 1 if seat.eql?('#')
  end
  count
end

def occupied_adjacent_seats_part2(r, c)
  count = 0
  offsets = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]]
  
  offsets.each do |offset|
    y = r + offset[0]
    x = c + offset[1]
    steps = 0

    until x.negative? || y.negative? || x >= @input.first.count || y >= @input.count      
      steps += 1
      seat = @seats.dig(y, x)
      break if seat.eql?('L')
      if seat.eql?('#')
        count += 1
        break
      end
      y = r + (offset[0] * steps)
      x = c + (offset[1] * steps)
    end
  end
  count
end

puts "Part 1: #{'part1()'} || Part 2: #{part2()}"