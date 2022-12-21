# frozen_string_literal: true

require 'set'
require 'json'

stream = File.open('input').readline.chomp.chars

window = []

stream.each_with_index do |c, i|
  window << c
  next if window.size < 14

  if window.to_set.size == 14
    p i + 1
    break
  end

  window.shift
end

p window
