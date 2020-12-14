@input = File.open('inputs/day13_input.txt').read.split("\n")

def part1()
  earliest_timestamp = @input[0].to_i
  bus_ids = @input[1].split(',').filter_map { |bus_id| bus_id.to_i if !bus_id.eql?('x') }
  current_ts = earliest_timestamp
  wait_time = earliest_bus = 0
  until wait_time != 0
    bus_ids.each do  |bus_id|
       if (current_ts % bus_id)  == 0
        wait_time = current_ts - earliest_timestamp 
        earliest_bus = bus_id
       end
    end
    current_ts += 1
  end
  wait_time * earliest_bus
end

def part2() # i needed some help with this one...
  busses = @input[1].scan(/\d+/).map(&:to_i)
  positions = @input[1].split(',').each_with_index.reject { |t, i| t == 'x' }.map(&:last)

  remainders = busses.zip(positions).map { |bus, pos| bus - (pos % bus) }
  product = busses.reduce(:*)

  multiples = busses.map do |num|
    base = product / num
    multiplier = (1..).find { |n| (n * base) % num == 1 }
    multiplier * base
  end

  multiples.each_with_index.map { |m, i| m * remainders[i] }.sum % product
end

puts "Part 1: #{part1()} || Part 2: #{part2()}"