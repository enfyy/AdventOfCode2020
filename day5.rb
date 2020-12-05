@input = File.open('inputs/day5_input.txt')
@boarding_passes = @input.read.split(' ')
@grid = Array.new(128, Array.new(8) {|i| i})
@seat_ids = []

def part1()
  highest_seat_id = 0
  @boarding_passes.each do |pass|
    row = find_index(pass[0..6], 'F', 'B')
    col = find_index(pass[7..9], 'L', 'R')
    seat_id = row * 8 + col
    #pp "Row: #{row} || Col: #{col} || Seat ID: #{seat_id}"
    @seat_ids.append(seat_id)
    highest_seat_id = seat_id if seat_id > highest_seat_id
  end
  return highest_seat_id
end

def both_parts()
  highest_seat_id = part1()
  missing_ids = []
  highest_seat_id.times do |i|
    missing_ids.append(i) unless @seat_ids.include?(i)
  end
  my_id = 0
  missing_ids.each do |id|
    my_id = id if @seat_ids.include?(id + 1) && @seat_ids.include?(id - 1)
  end
  puts "Part 1: #{highest_seat_id} || Part 2: #{my_id}"
  return nil
end

def find_index(chars, lower_c, upper_c)
  low = 0
  high = 2 ** chars.length
  chars.each_char do |c|
    rest = (low..high).size
    if c == lower_c
      high = low + rest / 2
    end
    if c == upper_c
      low = low + rest / 2
    end
  end
  return low
end

both_parts