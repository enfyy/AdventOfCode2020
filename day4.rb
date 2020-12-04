@input = File.open('inputs/day4_input.txt')
@passport_data = []
@input.read.split("\n\n").each do |passport|
  @passport_data.append(Hash[passport.split(" ").collect { |entry| [entry.split(":")[0], entry.split(":")[1] ] } ])
end

def part1()
  count = 0
  @passport_data.each { |passport| count += 1 if has_required_fields?(passport)}
  return count
end

def has_required_fields?(entry)
return (entry.key?('byr') && entry.key?('iyr') && entry.key?('eyr') &&
        entry.key?('hgt') && entry.key?('hcl') &&  entry.key?('ecl') && 
        entry.key?('pid'))
end

def part2()
  count = 0
  @passport_data.each do |passport|
    next unless has_required_fields?(passport)
    count += 1 if has_valid_values?(passport)
  end
  return count
end

def has_valid_values?(passport)
  return false unless (1920..2002).include?(passport['byr'].to_i)
  return false unless (2010..2020).include?(passport['iyr'].to_i)
  return false unless (2020..2030).include?(passport['eyr'].to_i)
  return false unless (passport['hgt'].end_with?('cm') && (150..193).include?(passport['hgt'].chomp('cm').to_i)) || (passport['hgt'].end_with?('in') && (59..76).include?(passport['hgt'].chomp('in').to_i))
  return false unless passport['hcl'].start_with?('#') && passport['hcl'].delete_prefix('#').length == 6 && passport['hcl'].delete_prefix('#').each_char.all? { |c| c.match?(/[0-9a-f]/) }
  return false unless ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(passport['ecl'])
  return false unless passport['pid'].length == 9 && passport['pid'].each_char.all? { |c| c.match?(/\d/) }
  return true
end

puts "Part 1: #{part1()} || Part 2: #{part2()}"