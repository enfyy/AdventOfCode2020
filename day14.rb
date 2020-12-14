@input = File.open('inputs/day14_input.txt').read.split("\n")
@bit_length = 36

def part1()
  mask = ''
  mem = []
  @input.each do |line|
    if line.start_with?('mask =')
      mask = line.split('=')[1].lstrip
    else
      adress = line.split('[')[1].split(']')[0].to_i
      mem[adress] = apply_bitmask(mask ,line.split('=')[1].lstrip.to_i)
    end
  end
  return mem.filter_map { |v| v }.sum
end

def apply_bitmask(mask, value)
  val_string = value.to_s(2)
  val_string = '0' * (@bit_length - val_string.length) + val_string #fill with zeros
  @bit_length.times do |i|
    val_string[i] = mask[i] unless mask[i].eql?('X')
  end
  val_string.to_i(2)
end

def part2()
  mask = ''
  mem = {}
  @input.each do |line|
    if line.start_with?('mask =')
      mask = line.split('=')[1].lstrip
    else
      adress = line.split('[')[1].split(']')[0].to_i
      val = line.split('=')[1].lstrip.to_i
      write_to_adresses(mem, mask, adress, val)
    end
  end
  return mem.values.filter_map { |v| v }.sum
end

def write_to_adresses(mem, mask, adress, value) # this is so complicated and im certain it shouldnt be
  
  floating_adress = adress.to_s(2)
  floating_adress = '0' * (@bit_length - floating_adress.length) + floating_adress #fill with zeros
  @bit_length.times do |i|
    floating_adress[i] = mask[i] if mask[i].eql?('X') || mask[i].eql?('1')
  end
 
  x_indices = []
  x_count = floating_adress.count('X')
  adress_count = 2.pow(x_count)
  adresses = []

  floating_adress.each_char.with_index do |c, i|
    x_indices.append(i) if c.eql?('X')
  end

  c = 1
  bit = 0
  table = []  
  x_count.times do |j|
    s = ''
    (0..adress_count).each_slice(c) do |slice|
      s += bit.abs.to_s * slice.length
      bit = ~ bit
    end
    table.append(s)
    c *= 2
  end

  permuts = []
  adress_count.times do |i|
    permuts.append(table.map { |row| row[i] })
  end

  permuts.each_with_index do |perm, i|
    add = floating_adress.dup
    perm.each_with_index do |c, i|
      add[x_indices[i]] = c
    end
    adresses.append(add)
  end

  adresses.each do |adress|
    mem[adress.to_i(2)] = value
  end
end

puts "Part 1: #{part1()} || Part 2: #{part2()}"