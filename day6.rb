@input = File.open('inputs/day6_input.txt')
@groups = @input.read.split("\n\n")

def part1()
  total = 0
  @groups.each do |group|
    single = []
    group.split("\n").each { |answers| single.concat(answers.split('')) }
    total += single.uniq.count
  end
  return total
end

def part2()
  total = 0
  @groups.each do |group|
    answers = []    
    group.split("\n").each { |person| answers.append(person.split('')) }
    inter = answers.first
    answers.each do |person|
      inter = inter.intersection(person)
    end
    total += inter.count
  end
  total
end

puts "Part 1: #{part1()} || Part 2: #{part2()}"