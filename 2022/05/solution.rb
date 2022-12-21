# frozen_string_literal: true

require 'pry-byebug'

part_one = false

file = File.open('input')

first_line = file.readline.chomp
file.rewind

number_of_stacks = (first_line.size + 1) / 4

stacks = Array.new(number_of_stacks) { [] }


# build stacks
until file.eof?
  line = file.readline.chomp

  if line[1] == '1'
    # we're at the " 1   2  3  4..." line, read the empty line below and then break
    file.readline
    break
  end

  number_of_stacks.times do |i|
    # crates are every four spaces, starting at position 1
    crate_position = i * 4 + 1
    next if line[crate_position] == ' '

    stacks[i].prepend(line[crate_position])
  end

end

file.readlines(chomp: true).each do |line|
  # a line looks like:
  # move 2 from 1 to 7
  # split on ' ' and we'll have:
  # [move, NumberOfCrates, from, SourceStack, to, DestinationStack]
  #   0         1            2       3         4       5
  line = line.split(' ')
  number_of_crates = line[1].to_i
  source_stack = line[3].to_i - 1
  destination_stack = line[5].to_i - 1

  if part_one
    number_of_crates.times do
      stacks[destination_stack] << stacks[source_stack].pop
    end
  else
    temp_stack = []
    number_of_crates.times do
      temp_stack << stacks[source_stack].pop
    end

    until temp_stack.empty?
      stacks[destination_stack] << temp_stack.pop
    end
  end
end

result = stacks.map { |stack| stack.last }.join

p result