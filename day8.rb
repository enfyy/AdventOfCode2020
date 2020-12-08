@input = File.open('inputs/day8_input.txt')
@instructions = @input.read.split("\n")

def part1()
  acc = 0
  pointer = 0
  executed_instructions = []
  until (executed_instructions.include?(pointer))
    executed_instructions.append(pointer)
    instruction = @instructions[pointer].split(' ')
    value = instruction[1].to_i
    command = instruction[0]    
    pointer += value if command.eql?('jmp')
    pointer += 1 if command.eql?('nop') || command.eql?('acc')
    acc += value if command.eql?('acc')    
  end
  acc
end

def part2()
  subset = []
  @instructions.each_with_index do |instruction, i|
    instruction = @instructions[i].split(' ')
    value = instruction[1].to_i
    command = instruction[0]
    sign = value.positive? ? '+' : ''
    subset = @instructions.dup

    if command.eql?('jmp')
      subset[i] = "nop #{sign}#{value}"
      break if instruction_set_terminates?(subset)
    end

    if command.eql?('nop')
      subset[i] = "jmp #{sign}#{value}"
      break if instruction_set_terminates?(subset)
    end
  end
  nil
end

def instruction_set_terminates?(instruction_set)
  acc = 0
  pointer = 0
  executed_instructions = []

  until (executed_instructions.include?(pointer))
    executed_instructions.append(pointer)
    instruction = instruction_set[pointer].split(' ')
    value = instruction[1].to_i
    command = instruction[0]

    pointer += value if command.eql?('jmp')
    pointer += 1 if command.eql?('nop') || command.eql?('acc')
    acc += value  if command.eql?('acc')
    return false if command.eql?('jmp') && value == 0
    if pointer > instruction_set.count - 1
      pp acc
      return true
    end
  end
  return false
end

puts "Part 1: #{part1()}"
puts "Part 2:"
part2()