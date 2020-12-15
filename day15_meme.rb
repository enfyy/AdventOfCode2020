# this is my first attempt at this and its pretty scuffed but part1 worked fine
# part2 ran out of memory so i wanted to meme a bit and just use redis instead of a hash
# it probably works but turns out its way too slow haha - who wouldve guessed
require 'redis'
@input = [7,14,0,17,11,1,2]

def get_memory_array(memory, key)
  memory.get(key).delete('[]').split(',').map(&:to_i)
end

def append_memory_array(memory, key, append)
  memory.set(key, get_memory_array(memory, key).append(append))
end

def part1()
  memory = Redis.new
  last_spoken = nil
  turn_counter = 1
  last_num_was_first_appearance = false
  @input.each do |num| #speak the starting numbers
    last_num_was_first_appearance = memory.get(num).nil?
    memory.set(num, [turn_counter])
    last_spoken = num
    turn_counter += 1
  end

  until turn_counter > 30000000 
    if last_num_was_first_appearance # last number was spoken before
      last_num_was_first_appearance = memory.get(0).nil?
      memory.get(0).nil? ? memory.set(0, [turn_counter]) : append_memory_array(memory, 0, turn_counter)
      last_spoken = 0
    else # last number was not spoken before
      mem_array = get_memory_array(memory, last_spoken)
      new_num = mem_array[-1] if mem_array.count == 1
      new_num = mem_array[-1] - mem_array[-2] if mem_array.count > 1
      
      last_num_was_first_appearance = memory.get(new_num).nil?
      last_num_was_first_appearance ? memory.set(new_num, [turn_counter]) : append_memory_array(memory, new_num, turn_counter)
      last_spoken = new_num
    end
    puts turn_counter
    turn_counter += 1
  end
  memory.flushdb
  last_spoken
end

pp part1