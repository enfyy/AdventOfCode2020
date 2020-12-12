@input = File.open('inputs/day12_input.txt').read.split("\n")

def part1()
  east_west = north_south = 0
  facing = 'E'
  @input.each do |line|
    instruction = line[0]
    value = line[1..-1].to_i
    north_south += value if instruction.eql?('N') || instruction.eql?('F') && facing.eql?('N')
    north_south -= value if instruction.eql?('S') || instruction.eql?('F') && facing.eql?('S')
    east_west   += value if instruction.eql?('E') || instruction.eql?('F') && facing.eql?('E')
    east_west   -= value if instruction.eql?('W') || instruction.eql?('F') && facing.eql?('W')
    facing = get_new_direction(facing, instruction ,value) if instruction.eql?('L') || instruction.eql?('R')
    #puts "ns:#{north_south} ew:#{east_west} facing: #{facing}"
  end
  return north_south.abs + east_west.abs
end

def get_new_direction(current_direction, rotate_direction ,value)  
  steps = value / 90
  steps = 4 - steps if rotate_direction.eql?('L')

  if steps == 1 && current_direction.eql?('W') ||
     steps == 2 && current_direction.eql?('S') ||
     steps == 3 && current_direction.eql?('E')
    return 'N'  
  end

  if steps == 1 && current_direction.eql?('N') ||
     steps == 2 && current_direction.eql?('W') ||
     steps == 3 && current_direction.eql?('S')
    return 'E'  
  end

  if steps == 1 && current_direction.eql?('E') ||
     steps == 2 && current_direction.eql?('N') ||
     steps == 3 && current_direction.eql?('W')
    return 'S'  
  end

  if steps == 1 && current_direction.eql?('S') ||
     steps == 2 && current_direction.eql?('E') ||
     steps == 3 && current_direction.eql?('N')
    return 'W'  
  end

  return current_direction
end

def part2()
  wp_east_west = 10
  wp_north_south = 1
  east_west = north_south = 0
  wp_facing = 'N'
  @input.each do |line|
    instruction = line[0]
    value = line[1..-1].to_i
    wp_north_south += value if instruction.eql?('N')
    wp_north_south -= value if instruction.eql?('S')
    wp_east_west   += value if instruction.eql?('E')
    wp_east_west   -= value if instruction.eql?('W')
    if instruction.eql?('L') || instruction.eql?('R')
      steps = value / 90
      steps = 4 - steps if instruction.eql?('L')
      steps.times do
        tmp = wp_north_south
        wp_north_south = wp_east_west * -1
        wp_east_west = tmp
      end
    end
    if instruction.eql?('F')
      value.times do        
        north_south += wp_north_south
        east_west   += wp_east_west
      end
    end    
  end
  return north_south.abs + east_west.abs
end

puts "Part 1: #{part1()} || Part 2: #{part2()}"