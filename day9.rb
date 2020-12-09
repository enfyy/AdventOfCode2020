@input = File.open('inputs/day9_input.txt').read.split("\n").map(&:to_i)
@preamble = 25

def part1(preamble_length)
  invalid_num = 0
  @input.each_with_index do |num, i|
    next unless (i > preamble_length)
    previous_numbers = @input[i-preamble_length..i]    
    invalid_num = num unless (previous_numbers.combination(2).any? { |combo_of_previous_nums| combo_of_previous_nums.sum == num })
  end
  invalid_num
end

def part2()
  invalid_num = part1(@preamble)
  @input.each_with_index do |num, i|
    offset = 1
    added = [num]
    while (added.sum < invalid_num)
      offset_num = @input[i + offset]
      added.append(offset_num)
      return added.min + added.max if (added.sum == invalid_num)
      offset += 1
    end
  end
end

puts "Part 1: #{part1(@preamble)} || Part 2: #{part2()}"