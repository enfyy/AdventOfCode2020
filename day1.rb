input = File.open("inputs/day1_input.txt")
@nums = []
input.each_with_index do |num, i|
    @nums[i] = num.chomp.to_i
end

def part1()
    @nums.permutation(2).to_a.each do |tuple|
        if tuple[0] + tuple[1] == 2020
            puts tuple[0] * tuple[1]
        end
    end
end

def part2()
    @nums.permutation(3).to_a.each do |triple|
        if triple[0] + triple[1] + triple[2] == 2020
            puts triple[0] * triple[1] * triple[2]
        end
    end
end

part1
part2