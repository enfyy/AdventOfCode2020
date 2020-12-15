# this is the new and improved version
@input = [7,14,0,17,11,1,2]

def elve_game(goal)
  memory = {}
  numbers = @input.dup
  numbers.each_with_index { |num, i| memory[num] = i} # starting numbers

  (goal - @input.count).times do 
    last_num = numbers[-1]
    i = memory[last_num] || numbers.count - 1

    number = numbers.count - 1 - i
    memory[last_num] = numbers.count - 1
    numbers << number
  end
  numbers[-1]
end

puts "Part 1: #{elve_game(2020)} || Part 2: #{elve_game(30000000)}"