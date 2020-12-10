@input = File.open('inputs/day10_input.txt').read.split("\n").map(&:to_i)

def part1()
  joltage = 0
  one_diff = 0
  three_diff = 1
  sorted_input = @input.sort
  sorted_input.each_with_index do |adapter, i|
    one_diff+=1 if (adapter - joltage == 1) 
    three_diff+=1 if (adapter - joltage == 3) 
    joltage = adapter
  end
  one_diff * three_diff
end

def part2()
  @input.append(0)
  @input.append(@input.max + 3)
  data = @input.sort
  paths = [0] * (data.max + 1)
  paths[0] = 1
  (1..data.max).each do |i|
    (1..3).each do |j|
      paths[i] += paths[i - j] if data.include?(i - j)
    end    
  end
  paths[-1]
end

puts "Part 1: #{part1()} || Part 2: #{part2()}"