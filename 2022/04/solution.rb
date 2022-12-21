
class Section
  class << self
    def parse(string_range)
      lower, upper = string_range.split('-').map(&:to_i)
      new(lower: lower, upper: upper)
    end
  end

  attr_reader :lower, :upper

  def initialize(lower:, upper:)
    @lower = lower
    @upper = upper
  end

  def subset_of?(other_section)
    lower >= other_section.lower && upper <= other_section.upper
  end

  def overlaps?(other_section)
    lower <= other_section.upper && upper >= other_section.lower
  end
end

count = 0
count_b = 0

File.open('input').readlines.each do |line|
  first_section, second_section = line.chomp.split(',').map { |range| Section.parse(range) }
  count += 1 if first_section.subset_of?(second_section) || second_section.subset_of?(first_section)
  count_b += 1 if first_section.overlaps?(second_section)
end

p count
p count_b
