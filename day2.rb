@input = File.open('inputs/day2_input.txt')

def count_valid()
    part1_count = 0
    part2_count = 0

    @input.each do |line|
        line_sections = line.split(' ')
        count_section = line_sections[0].split('-')        
        part1_count += 1 if part1_valid_password?(line_sections[2], line_sections[1][0], count_section[0].to_i, count_section[1].to_i)
        part2_count += 1 if part2_valid_password?(line_sections[2], line_sections[1][0], count_section[0].to_i, count_section[1].to_i)
    end
    puts "Part 1: #{part1_count} || Part 2: #{part2_count}"
end

def part1_valid_password?(pw, character, min, max)    
    return (min..max).include?(pw.each_char.count(character))
end

def part2_valid_password?(pw, character, pos1, pos2)
    return (pw[pos1 - 1] == character) ^ (pw[pos2 - 1] == character)
end

count_valid