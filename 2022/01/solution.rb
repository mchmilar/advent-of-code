require 'pry-byebug'

elf_number = 1
elf_calorie_count = 0

most_calories = {
  elf_number: 0,
  calories: -1,
}

File.open('input').readlines.each do |line|
  if line.chomp.empty?
    if elf_calorie_count > most_calories[:calories]
      most_calories[:elf_number] = elf_number
      most_calories[:calories] = elf_calorie_count
    end
    elf_number += 1
    elf_calorie_count = 0
  else
    elf_calorie_count += line.chomp.to_i
  end
end

if elf_calorie_count > most_calories[:calories]
  most_calories[:elf_number] = elf_number
  most_calories[:calories] = elf_calorie_count
end


pp most_calories

count = 0
counts = []

File.open('input').readlines.each do |line, i|
  if line.chomp.empty?
    counts << count
    count = 0
  else
    count += line.chomp.to_i
  end
end

counts << count

counts.sort!.reverse!

p counts[0] + counts[1] + counts[2]
