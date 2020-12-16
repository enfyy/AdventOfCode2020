@input = File.open('inputs/day16_input.txt').read.split("\n\n")

def both_parts()
  rules_section = @input[0].split("\n")
  my_ticket = @input[1].split("\n")
  my_ticket.delete_at(0)
  my_ticket = my_ticket[0].split(',').map(&:to_i)
  nearby_tickets_section = @input[2].split("\n")
  nearby_tickets_section.delete_at(0)

  rules = {}  # determine the ranges 
  rules_section.each do |line|
    key_and_val = line.split(':')
    key = key_and_val[0]
    val_ranges = key_and_val[1].lstrip.split('or')
    range_arr1 = val_ranges[0].rstrip.split('-')
    range_arr2 = val_ranges[1].lstrip.split('-')
    rules[key] = [range_arr1[0].to_i..range_arr1[1].to_i, range_arr2[0].to_i..range_arr2[1].to_i] 
  end

  error_values = []
  valid_tickets = [] # sort out invalid tickets
  nearby_tickets_section.each do |ticket|
    valid_ticket = true
    ticket.split(',').each do |ticket_value|
      if rules.values.any? { |range_arr| range_arr[0].include?(ticket_value.to_i) || range_arr[1].include?(ticket_value.to_i) }
        next
      else
        valid_ticket = false
        error_values.append(ticket_value.to_i)
        break
      end
    end
    valid_tickets.append(ticket) if valid_ticket
  end

  puts "Part 1: #{error_values.sum}" # result of part 1

  col_fits_for_key = {}
  valid_tickets = valid_tickets.map { |ticket| ticket.split(',') }
  col_count = valid_tickets.first.count
  rules.each do |key, ranges| # determine the order of 
    col_count.times do |c|
      col = valid_tickets.map { |ticket| ticket[c].to_i }
      #pp "checking #{col} for #{ranges}"
      if col.all? { |v| ranges[0].include?(v) || ranges[1].include?(v) }
        col_fits_for_key[c].nil? ? col_fits_for_key[c] = [key] : col_fits_for_key[c].append(key)        
      end
    end 
  end

  #pp col_fits_for_key
  definitive_col_to_key_map = {}
  sorted = col_fits_for_key.sort { |k, v| v.count }  
  
  used_keys = []
  until definitive_col_to_key_map.keys.count == sorted.size
    sorted.each do |arr|
      col = arr[0]
      fitting_keys = arr[1] - used_keys
      if fitting_keys.count == 1
        definitive_col_to_key_map[col] = fitting_keys.first
        used_keys.append(fitting_keys.first)
      end
    end
  end
  
  values = []
  definitive_col_to_key_map.each do |col, key|
    next unless key.start_with?('departure')
    values.append(my_ticket[col])
  end

  puts "Part 2: #{values.inject(:*)}"
end

both_parts