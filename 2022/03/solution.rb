require 'pry-byebug'
require 'set'

score = 0

File.open('input').readlines.each do |line|
  line.chomp!

  first_half = line[0, line.size / 2].chars.to_set
  second_half = line[line.size / 2, line.size].chars.to_set

  ord = (first_half & second_half).first.ord

  priority = if ord >= 'a'.ord
    ord - 96
  else
    ord - 38
  end

  score += priority
end


p score
score = 0
File.open('input').each_slice(3) do |slice|
  first, second, third = slice.map(&:chomp).map { |sack| sack.chars.to_set }

  ord = (first & second & third).first.ord

  priority = if ord >= 'a'.ord
    ord - 96
  else
    ord - 38
  end

  score += priority
end

p score