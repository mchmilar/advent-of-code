require 'pry-byebug'

class Move
  attr_reader :code

  class << self
    def from_outcome(other_move:, outcome:)
      if outcome == 'X'
        return scissors if other_move.rock?
        return rock if other_move.paper?
        return paper if other_move.scissors?
      elsif outcome == 'Y'
        return scissors if other_move.scissors?
        return rock if other_move.rock?
        return paper if other_move.paper?
      elsif outcome == 'Z'
        return scissors if other_move.paper?
        return paper if other_move.rock?
        return rock if other_move.scissors?
      end
    end

    def rock
      new('A')
    end

    def paper
      new('B')
    end

    def scissors
      new('C')
    end
  end

  def initialize(code)
    @code = code
  end

  def rock?
    score == 1
  end

  def paper?
    score == 2
  end

  def scissors?
    score == 3
  end

  def score
    if code == 'A' || code == 'X'
      1
    elsif code == 'B' || code == 'Y'
      2
    elsif code == 'C' || code == 'Z'
      3
    else
      raise "wtf"
    end
  end

  def ties?(other_move)
    score == other_move.score
  end

  def beats?(other_move)
    if score == 1
      return false if other_move.score == 1
      return false if other_move.score == 2
      return true if other_move.score == 3
    elsif score == 2
      return true if other_move.score == 1
      return false if other_move.score == 2
      return false if other_move.score == 3
    elsif score == 3
      return false if other_move.score == 1
      return true if other_move.score == 2
      return false if other_move.score == 3
    else
      raise 'huh?'
    end
  end
end

class Game
  attr_reader :my_move, :other_move

  def initialize(other_move, my_move)
    @other_move = other_move
    @my_move = my_move
  end

  def score
    if other_move.ties?(my_move)
      3 + my_move.score
    elsif other_move.beats?(my_move)
      my_move.score
    else
      6 + my_move.score
    end
  end
end



score = 0

File.open('input').readlines.each do |line|
  other_move, my_move = line.chomp.split(' ').map { |code| Move.new(code) }
  score += Game.new(other_move, my_move).score
end

puts score

score = 0

File.open('input').readlines.each do |line|
  other_move_code, outcome_code = line.chomp.split(' ')
  other_move = Move.new(other_move_code)
  my_move = Move.from_outcome(other_move: other_move, outcome: outcome_code)
  log = { other_move: other_move, my_move: my_move }
  pp log
  score += Game.new(other_move, my_move).score
end

puts score