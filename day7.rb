@input = File.open('inputs/day7_input.txt')
@my_bag_type = "shiny gold"
@rules = {}

def parse_and_format_for_part_1()
  @total = 0
  @rules.clear()
  @input.read.split("\n").each do |rule|
    rule_line = rule.split("contain")
    key = rule_line[0].gsub(" bags ","")
    val = []
    content = rule_line[1].chomp('.')
    unless content == " no other bags"
      content.split(",").each do |inner_bags|
        bag = inner_bags.chomp("s").gsub(" bag","")
        bag[0] = ""
        words = bag.split(" ")
        val.append(words[1].concat(" #{words[2]}"))
      end      
    end
    @rules[key] = val
  end
  nil
end

def part1()
  parse_and_format_for_part_1()
  @total = 0
  @rules.keys.each do |bag_type|    
    next if @my_bag_type.eql?(bag_type)
    open_bag_part1(bag_type, @my_bag_type)
  end
  @total
end

def open_bag_part1(bag_name, desired_bag)
  content = @rules[bag_name]

  return if content.count == 0
  found = false
  content.each do |inner_bag|
    if inner_bag.eql?(desired_bag)
      @total +=1
      return true
    else
      found = open_bag_part1(inner_bag, desired_bag)
    end
    return true if found
  end
  false
end

def parse_and_format_for_part_2()
  @total = 0
  @rules.clear()
  @input.read.split("\n").each do |rule|
    rule_line = rule.split("contain")
    key = rule_line[0].gsub(" bags ","")
    val = []
    content = rule_line[1].chomp('.')
    unless content == " no other bags"
      content.split(",").each do |inner_bags|
        bag = inner_bags.chomp("s").gsub(" bag","")
        bag[0] = ""
        val.append(bag)
      end      
    end
    @rules[key] = val
  end
end

def part2()
  parse_and_format_for_part_2()
  @total = open_bag_part2(@my_bag_type)
  puts @total
end

def open_bag_part2(bag_type)
  inner_total = 0
  content = @rules[bag_type]  
  if content.count == 0
    return 1
  else
    content.each do |inner_bag|
      inner_bag_count = inner_bag[0].to_i # its only single digits, right ???
      inner_bag_total = open_bag_part2(inner_bag[2..inner_bag.length])
      if inner_bag_total == 1
        inner_total += inner_bag_count * open_bag_part2(inner_bag[2..inner_bag.length])
      else
        inner_total += inner_bag_count * open_bag_part2(inner_bag[2..inner_bag.length]) + inner_bag_count
      end
    end    
  end  
  return inner_total
end

puts part1()
#puts part2()